const http = require('http');
const https = require('https');

const DELAY_MS = 15000;
let lastRequestTime = 0;

const AGENTIC_ROUTES = ['/chat/completions', '/messages', '/responses'];

const server = http.createServer(async (req, res) => {
  let targetPath = req.url;
  if (targetPath.startsWith('/v1/')) {
    targetPath = '/api' + targetPath;
  } else if (!targetPath.startsWith('/api/v1/')) {
    targetPath = '/api/v1' + targetPath;
  }

  const route = targetPath.replace(/^\/api\/v1/, '');
  if (!AGENTIC_ROUTES.some((r) => route === r || route.startsWith(r + '/'))) {
    res.writeHead(404, { 'content-type': 'application/json' });
    res.end(JSON.stringify({ error: 'Route not proxied' }));
    return;
  }

  const now = Date.now();
  const waitTime = Math.max(0, DELAY_MS - (now - lastRequestTime));
  lastRequestTime = Math.max(now, lastRequestTime) + DELAY_MS;

  console.log(`[${req.method}] ${req.url} in ${waitTime/1000} sec...`)
  if (waitTime > 0) await new Promise((r) => setTimeout(r, waitTime));
  console.log(`[${req.method}] ${req.url} sent`)

  const headers = { ...req.headers };
  delete headers.connection;
  headers.host = 'openrouter.ai';

  const proxyReq = https.request(
    {
      hostname: 'openrouter.ai',
      port: 443,
      path: targetPath,
      method: req.method,
      headers,
    },
    (proxyRes) => {
      res.writeHead(proxyRes.statusCode, proxyRes.headers);
      proxyRes.pipe(res);
    }
  );

  proxyReq.on('error', (err) => {
    res.writeHead(502, { 'content-type': 'application/json' });
    res.end(JSON.stringify({ error: err.message }));
  });

  req.pipe(proxyReq);
});

server.listen(4000);
