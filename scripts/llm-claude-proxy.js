// LLM Claude Proxy
//
// Faux endpoint OpenAI /chat/completions pour le BYOK de VS Code Copilot.
// Au lieu de relayer vers un provider, chaque requête est transmise à
// `claude -p` : une conversation Copilot = une session Claude.
//
// Usage : node scripts/llm-claude-proxy.js   (PORT=4001, CWD=/chemin/projet, CLAUDE_ARGS="--model sonnet")
// Claude est toujours lancé avec --permission-mode auto et dans CWD.
// Config Copilot : URL de base http://localhost:4001
//
// Seuls les messages `user` de Copilot comptent : le system prompt, les
// messages assistant et les tool calls sont ignorés. Claude garde son propre
// historique via --resume.

const http = require("http");
const crypto = require("crypto");
const { spawn } = require("child_process");

const PORT = Number(process.env.PORT) || 4001;
// Dossier de travail de Claude : explicite, par défaut celui du proxy.
const CWD = process.env.CWD || process.cwd();
const EXTRA_ARGS =(process.env.CLAUDE_ARGS || "").split(/\s+/).filter(Boolean);

// --- Mapping conversation -> session ID (en mémoire, perdu au redémarrage) ---

const sessions = {};

// --- Helpers ----------------------------------------------------------------

function textOf(content) {
  if (typeof content === "string") return content;
  if (Array.isArray(content)) {
    return content
      .filter((p) => p && p.type === "text")
      .map((p) => p.text)
      .join("\n");
  }
  return "";
}

// Texte réel de l'utilisateur. Au tour courant, Copilot l'enveloppe dans
// <prompt> (ou <userRequest>) après les instructions et pièces jointes ; dans
// l'historique, il renvoie le texte nu. On extrait donc la dernière balise en
// fin de message (un fichier joint peut lui-même contenir "<prompt>").
// Sépare un message Copilot en { text, attachments } : le texte nu (stable,
// sert à la clé) et le bloc <attachments> du tour courant (vide dans
// l'historique). Les instructions qui précèdent sont ignorées.
function split(text) {
  const t = text.trim();
  for (const tag of ["prompt", "userRequest"]) {
    const close = `</${tag}>`;
    if (!t.endsWith(close)) continue;
    const start = t.lastIndexOf(`<${tag}>`);
    if (start < 0) continue;
    const before = t.slice(0, start);
    const a0 = before.indexOf("<attachments>");
    const a1 = before.lastIndexOf("</attachments>");
    return {
      text: t.slice(start + tag.length + 2, t.length - close.length).trim(),
      attachments: a0 >= 0 && a1 > a0 ? before.slice(a0, a1 + "</attachments>".length) : "",
    };
  }
  return { text: t, attachments: "" };
}

const normalize = (text) => split(text).text;

function json(res, status, body) {
  res.writeHead(status, { "content-type": "application/json" });
  res.end(JSON.stringify(body));
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    const chunks = [];
    req.on("data", (c) => chunks.push(c));
    req.on("end", () => resolve(Buffer.concat(chunks).toString("utf8")));
    req.on("error", reject);
  });
}

// File d'attente par conversation : une requête à la fois par session.
const queues = new Map();
function enqueue(key, task) {
  const prev = queues.get(key) || Promise.resolve();
  const next = prev.catch(() => {}).then(task);
  queues.set(key, next);
  next
    .finally(() => {
      if (queues.get(key) === next) queues.delete(key);
    })
    .catch(() => {});
  return next;
}

// Lance claude. onText reçoit les deltas ; résout avec { sessionId }.
function runClaude({ prompt, sessionId, onText, signal }) {
  return new Promise((resolve, reject) => {
    const args = [
      "-p",
      "--output-format", "stream-json",
      "--verbose",
      "--include-partial-messages",
      "--permission-mode", "auto",
      ...EXTRA_ARGS,
    ];
    if (sessionId) args.push("--resume", sessionId);

    const child = spawn("claude", args, { cwd: CWD, stdio: ["pipe", "pipe", "pipe"] });
    let stderr = "";
    let buffer = "";
    let newSessionId = sessionId;
    let hasText = false;
    let needSeparator = false;

    signal.addEventListener("abort", () => child.kill("SIGTERM"));

    child.stderr.on("data", (d) => (stderr += d));
    child.stdout.on("data", (d) => {
      buffer += d;
      let idx;
      while ((idx = buffer.indexOf("\n")) >= 0) {
        const line = buffer.slice(0, idx).trim();
        buffer = buffer.slice(idx + 1);
        if (!line) continue;
        let ev;
        try {
          ev = JSON.parse(line);
        } catch {
          continue;
        }
        if (ev.session_id) newSessionId = ev.session_id;
        if (ev.type !== "stream_event") continue;
        const e = ev.event;
        if (e.type === "content_block_start" && e.content_block?.type === "text" && hasText) {
          needSeparator = true;
        } else if (e.type === "content_block_delta" && e.delta?.type === "text_delta") {
          let text = e.delta.text;
          if (needSeparator) {
            text = "\n\n" + text;
            needSeparator = false;
          }
          hasText = true;
          onText(text);
        }
      }
    });

    child.on("error", reject);
    child.on("close", (code) => {
      if (code === 0) resolve({ sessionId: newSessionId });
      else reject(Object.assign(new Error(stderr.trim() || `claude exited with ${code}`), { code }));
    });

    child.stdin.end(prompt);
  });
}

// --- Serveur ----------------------------------------------------------------

const server = http.createServer(async (req, res) => {
  const url = req.url
    .split("?")[0]
    .replace(/^\/api/, "")
    .replace(/^\/v1/, "");

  if (req.method === "GET" && url === "/models") {
    return json(res, 200, {
      object: "list",
      data: [{ id: "claude", object: "model", owned_by: "claude-cli" }],
    });
  }
  if (req.method !== "POST" || url !== "/chat/completions") {
    return json(res, 404, { error: "Route not proxied" });
  }

  let body;
  try {
    body = JSON.parse(await readBody(req));
  } catch {
    return json(res, 400, { error: "Invalid JSON" });
  }

  const userMessages = (body.messages || [])
    .filter((m) => m.role === "user")
    .map((m) => textOf(m.content))
    .filter(Boolean);
  if (userMessages.length === 0) return json(res, 400, { error: "No user message" });

  // À Claude : les pièces jointes du tour courant + le texte nu de l'utilisateur,
  // sans les instructions de Copilot.
  const last = split(userMessages[userMessages.length - 1]);
  const prompt = last.attachments ? `${last.attachments}\n\n${last.text}` : last.text;

  // Chaînage : la session est enregistrée sous le hash du dernier message user
  // et retrouvée au tour suivant via l'avant-dernier. Le premier message n'est
  // pas stable d'un tour à l'autre (Copilot ré-injecte du contexte).
  const hashes = userMessages.map((m) => crypto.createHash("sha256").update(normalize(m)).digest("hex"));
  const curKey = hashes[hashes.length - 1];
  const prevKey = hashes.length > 1 ? hashes[hashes.length - 2] : null;
  const key = prevKey || curKey;
  if (process.env.DEBUG) {
    console.log(`  roles: ${(body.messages || []).map((m) => m.role).join(",")}`);
    console.log(userMessages.map((m, i) => `  user[${i}] ${hashes[i].slice(0, 8)} len=${m.length} raw=${JSON.stringify(m.slice(0, 120))} … ${JSON.stringify(m.slice(-120))}`).join("\n"));
  }
  const model = body.model || "claude";
  const stream = body.stream === true;
  const id = "chatcmpl-" + crypto.randomUUID();
  const created = Math.floor(Date.now() / 1000);

  const ac = new AbortController();
  res.on("close", () => {
    if (!res.writableFinished) ac.abort();
  });

  const chunk = (delta, finish = null) =>
    `data: ${JSON.stringify({
      id,
      object: "chat.completion.chunk",
      created,
      model,
      choices: [{ index: 0, delta, finish_reason: finish }],
    })}\n\n`;

  await enqueue(key, async () => {
    let sessionId = prevKey ? sessions[prevKey] : undefined;
    console.log(`[${key.slice(0, 8)}] ${sessionId ? "resume " + sessionId : "new session"}`);

    let full = "";
    let started = false;
    const onText = (t) => {
      full += t;
      if (!stream) return;
      if (!started) {
        started = true;
        res.writeHead(200, {
          "content-type": "text/event-stream",
          "cache-control": "no-cache",
          connection: "keep-alive",
        });
        res.write(chunk({ role: "assistant", content: "" }));
      }
      res.write(chunk({ content: t }));
    };

    // DEBUG : appel à Claude désactivé, on renvoie à la place la conversation
    // reçue de Copilot et le prompt qui serait envoyé à Claude.
    const attempt = (sid) => runClaude({ prompt, sessionId: sid, onText, signal: ac.signal });
    // const attempt = async (sid) => {
    //   const conversation = (body.messages || [])
    //     .map((m, i) => `--- [${i}] ${m.role} ---\n${textOf(m.content) || JSON.stringify(m.content ?? m.tool_calls ?? '')}`)
    //     .join('\n\n');
    //   onText(
    //     `# Conversation reçue de Copilot (${(body.messages || []).length} messages)\n\n${conversation}\n\n` +
    //       `# Session\n\nclé: ${key}\n${sid ? 'resume ' + sid : 'nouvelle session'}\n` +
    //       `commande: claude -p --output-format stream-json --verbose --include-partial-messages${sid ? ' --resume ' + sid : ''}\n\n` +
    //       `# Prompt envoyé à Claude (stdin)\n\n${prompt}\n`
    //   );
    //   return { sessionId: sid };
    // };

    try {
      let result;
      try {
        result = await attempt(sessionId);
      } catch (err) {
        // Session introuvable : on repart sur une nouvelle session.
        if (sessionId && !full && !ac.signal.aborted) {
          console.log(`[${key.slice(0, 8)}] resume failed (${err.message}), new session`);
          delete sessions[prevKey];
          result = await attempt(undefined);
        } else {
          throw err;
        }
      }
      if (result.sessionId && sessions[curKey] !== result.sessionId) {
        sessions[curKey] = result.sessionId;
      }

      if (stream) {
        if (!started) {
          res.writeHead(200, { "content-type": "text/event-stream", "cache-control": "no-cache" });
          res.write(chunk({ role: "assistant", content: "" }));
        }
        res.write(chunk({}, "stop"));
        res.write("data: [DONE]\n\n");
        res.end();
      } else {
        json(res, 200, {
          id,
          object: "chat.completion",
          created,
          model,
          choices: [{ index: 0, message: { role: "assistant", content: full }, finish_reason: "stop" }],
          usage: { prompt_tokens: 0, completion_tokens: 0, total_tokens: 0 },
        });
      }
      console.log(`[${key.slice(0, 8)}] done`);
    } catch (err) {
      console.error(`[${key.slice(0, 8)}] error: ${err.message}`);
      if (res.writableEnded) return;
      if (started) {
        res.write(chunk({ content: `\n\n[claude error: ${err.message}]` }, "stop"));
        res.write("data: [DONE]\n\n");
        res.end();
      } else {
        json(res, 502, { error: { message: err.message } });
      }
    }
  });
});

server.listen(PORT, () => console.log(`LLM Claude Proxy on http://localhost:${PORT}`));
