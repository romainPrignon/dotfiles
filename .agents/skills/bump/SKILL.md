---
name: bump
description: Recipe to bump major version of dependencies
---

- run `pnpm outdated --json`
- focus on major only
- group related dependencies together
- for each major group
  - search offical changelog/release note
  - update `package.json`
  - run `pnpm i`
  - run `pnpm build && pnpm lint && pnpm test && pnpm e2e`
  - if OK
    - commit the group update
  - if NOK
    - fix the issue
    - after 3 fix attempt, ask for help
