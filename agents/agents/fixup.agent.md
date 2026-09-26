---
name: fixup
description: Address review comments
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
