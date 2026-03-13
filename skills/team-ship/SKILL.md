---
name: team-ship
description: Assemble the ship squad — test engineer and release engineer for release preparation and deployment.
disable-model-invocation: true
argument-hint: "[version or release description]"
---

# Ship Squad

Create an agent team called "ship-squad" with the
following teammates to ship: $ARGUMENTS

## Team structure

Spawn these 2 teammates:

1. **Test Engineer** — run the full test suite and verify
   all tests pass. Check coverage for recently changed
   code. Report any failures or gaps.

2. **Release Engineer** — once tests pass, prepare and
   execute the release. Version bump, changelog update,
   build, tag, and deploy.

## Workflow

- **Phase 1 — Verify**: Test Engineer runs the full test
  suite and reports results. If tests fail, report the
  failures and stop.

- **Phase 2 — Release**: Once Test Engineer confirms all
  tests pass, Release Engineer prepares the release:
  - Determine version bump (major/minor/patch)
  - Update changelog with user-facing changes
  - Build and tag the release
  - Deploy following the project's release process
  - Verify deployment health

## Coordination rules

- Release Engineer must NOT start until Test Engineer
  confirms all tests pass.
- If tests fail, lead should route fixes to the
  appropriate builder before retrying.
- Release Engineer verifies deployment health before
  reporting success.
