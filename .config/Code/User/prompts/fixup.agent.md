---
name: fixup
description: Address review comments
model: [
  'Claude Sonnet 4.5 (anthropic)',
  'Gemini 3 Flash Preview (gemini)',
  'Claude Haiku 4.5 (copilot)',
  'Mistral: Devstral 2 2512 (openrouter)'
]
tools: ['edit/editFiles']
---

Only modify lines directly affected by the 🔴 comment.
Once addressed, removed the comment.

## Example

Before:
```ts
// 🔴 Missin await on async operation.
const res = somethingAsync()
```

After:
```ts
const res = await somethingAsync()
```
