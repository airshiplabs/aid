# ADR-005: Permission Mode Strategy

**Status:** Accepted
**Date:** 2026-03-13

## Context

Claude Code agents operate under permission modes that control what actions they can take. The two relevant modes are:

- **`plan`**: the agent can read files and reason but cannot make edits. Suitable for analysis and review.
- **`acceptEdits`**: the agent can read, write, and execute commands. Required for implementation.

Granting all agents full edit permissions would be the simplest configuration but creates unnecessary risk: a reviewer agent accidentally modifying code, or a researcher making changes while exploring. Permissions should match responsibilities.

## Decision

We assign permission modes based on each agent's role:

**Analysis roles (`plan` mode):**

- Researcher — explores but does not modify
- Architect — designs but does not implement
- Code Reviewer — reviews but does not fix
- Security Reviewer — audits but does not patch
- All 8 Principles Guild reviewers — score but do not modify

**Builder roles (`acceptEdits` mode):**

- Backend Engineer — implements server-side changes
- Frontend Engineer — implements client-side changes
- Test Engineer — writes and updates tests
- Release Engineer — prepares releases and deployment artifacts

## Consequences

**What becomes easier:**

- Agents cannot accidentally exceed their role. A reviewer cannot silently "fix" something it disagrees with.
- The permission boundary makes agent roles self-documenting — you can tell a builder from a reviewer by checking its permission mode.
- Reduces the blast radius of agent mistakes: analysis agents can only produce bad advice, not bad code.

**What becomes harder:**

- The Architect operates in `plan` mode but needs to write ADR files. This requires the Architect agent to have Write in its tools list alongside plan mode for docs-only output.
- If a reviewer identifies a trivial fix, it cannot apply it directly — a builder must be involved, adding latency.
- Permission modes are static per agent definition and cannot adapt to context (e.g., a reviewer granted temporary edit access for a hotfix).
