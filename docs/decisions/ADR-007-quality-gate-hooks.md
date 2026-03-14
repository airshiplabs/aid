# ADR-007: Quality Gate Hooks

**Status:** Accepted
**Date:** 2026-03-13

## Context

Builder agents (Backend Engineer, Frontend Engineer, Test Engineer, Release Engineer) can mark tasks complete or go idle without actually verifying their work. Without enforcement, an agent might declare "done" without running tests, producing code that passes review but fails at runtime.

Claude Code provides two hook points relevant to quality enforcement:

- **TeammateIdle**: fires when an agent is about to stop working.
- **TaskCompleted**: fires when an agent marks a task as done.

These hooks can run shell scripts that inspect the agent's transcript or task description for evidence of verification, blocking the action if evidence is missing.

## Decision

We implement two quality gate hooks as shell scripts:

**TeammateIdle hook** (`validate-teammate-idle.sh`): For builder agents (backend-engineer, frontend-engineer, test-engineer), the script searches the agent's transcript for evidence of test execution (patterns like "tests pass", "all pass", "0 failed"). If no evidence is found, it exits with code 2 and feedback instructing the agent to run tests. The Release Engineer is not covered by this hook — it passes through automatically along with all non-builder agents.

**TaskCompleted hook** (`validate-task-completion.sh`): For each builder role, the script searches the task description for role-appropriate evidence:

- Backend/Frontend Engineers: test results
- Test Engineer: test output
- Release Engineer: quality gates, version bump, changelog evidence

Non-builder agents pass through automatically.

An early bug (fixed in commit 03000d4) caused builder agents to enter infinite rejection loops because the scripts had no pass-through path — they always exited with code 2 for builders, even when test evidence was present. The fix added proper evidence checking before the rejection path.

## Consequences

**What becomes easier:**

- Builders cannot silently skip verification. The hook forces them to run tests and include results.
- Quality evidence is captured in task descriptions and transcripts, creating an audit trail.
- Non-builders are unaffected — the pass-through path keeps the hooks invisible to reviewers and researchers.

**What becomes harder:**

- Evidence detection relies on regex pattern matching against transcript and description text. False negatives are possible if test output uses unexpected formatting.
- The hooks add latency to every task completion and idle transition for builders.
- Hook scripts must be maintained alongside agent definitions — if new builder roles are added, the case statements must be updated.
