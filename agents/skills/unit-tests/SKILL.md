---
name: unit-tests
description: Guidelines for writing, structuring, and refactoring unit tests consistently
---

Prefer current repository established convention.
Apply these guidelines only if they are relevant.
Mocking: `msw` and `vi` from vitest.
Type Checking: `@total-typescript/shoehorn` to arrange inputs.

# Testing Stack

- Test Runner: Vitest
- Assertion: Vitest

# Principles

- Focused Tests: each unit test should focus on one functionality. 
- Isolated tests: ensure each test is isolated and does not depend on others.
- Concurrent tests: use concurrent test when possible.
- Aim for 100% code coverage

# What to test

- Happy path: all public API behavior
- Failures: unexpected conditions and errors scenarios
- Edge cases
- Type tests: use a `test-d.ts` file

# Structure

- Use descriptive names: `should [behavior] when [condition]`
- Use the Arrange/Act/Assert pattern with explicit comments
  - do NOT mix Act & Assert
- Add clarifying comments to explain test variations
- Use consistent structure across all tests
- Organized by method: uses nested describe blocks for each class/module method
- Add minimal test runner hooks if necessary

# Arrangments

- add comments to the `arrange` and `mock` section to clarify intent

# Assertions

- Verify **output values**
- Verify **observable state** changes
- Verify **side effects** (use spies)
- Use `toMatchInlineSnapshot()` for complex objects/arrays
  - Use `toEqual()` otherwise
- Use `toThrowErrorMatchingInlineSnapshot()` for errors

# Mocking strategy

- Mock should be used as a last resort
- Prefer the `spy` syntax over the `mock` one
- Mock should be local to each test
- Mock should live is a `// mock` section between `arrange` and `act`
- Cleanup mocks in the test runner hook if necessary.

# Examples

```typescript
// filename: myModule.test.ts
import { beforeEach, describe, expect, it, vi } from 'vitest'
// test
import { myMethod } from './myModule.ts'

// mock
import { logger } from './logger.ts'

beforeEach(() => {
  vi.restoreAllMocks()
})

describe('myMethod', () => {
  it('should return result when input is valid', () => {
    // Arrange
    const input = 'test'

    // mock
    const loggerSpy = vi.spyOn(logger, 'info')

    // Act
    const result = myMethod(input)

    // Assert
    expect(result).toEqual('expected')
    expect(loggerSpy).toHaveBeenCalledWith('Processing: data')
  })
})
```
