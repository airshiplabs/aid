---
name: team-build
description: Assemble the build squad — backend engineer, frontend engineer, and test engineer for parallel implementation work.
disable-model-invocation: true
argument-hint: "[task description]"
---

# Build Squad

Create an agent team called "build-squad" with the
following teammates to implement: $ARGUMENTS

## Team structure

Spawn these 4 teammates:

1. **Researcher** — explore the codebase to understand
   the existing code, dependencies, and conventions
   relevant to the task. Share findings with the builders.

2. **Backend Engineer** — implement server-side changes:
   APIs, data models, business logic. Own backend files
   only. Run tests after implementation.

3. **Frontend Engineer** — implement client-side changes:
   UI components, interactions, state management. Own
   frontend files only. Run tests after implementation.

4. **Test Engineer** — write tests alongside the builders.
   Cover happy paths, edge cases, and error paths. Own
   test files only. Coordinate with builders on what
   needs coverage.

## Workflow

- **Phase 1 — Context**: Researcher gathers context and
  shares findings with all builders.

- **Phase 2 — Build**: All three builders work in parallel.
  Each owns separate files to avoid conflicts. Test
  Engineer coordinates with builders on test coverage.

- **Phase 3 — Verify**: Each builder runs tests for their
  own changes. Test Engineer runs the full suite and
  reports any failures.

## Coordination rules

- Teammates must NOT edit the same files. Assign file
  ownership explicitly in tasks.
- Create 5-6 tasks per teammate for steady progress.
- If a builder is blocked, they message the relevant
  teammate directly rather than waiting.
- Test Engineer should start writing tests as soon as
  interfaces are defined, not after implementation.
