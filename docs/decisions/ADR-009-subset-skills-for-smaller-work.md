# ADR-009: Subset Skills for Smaller Work

**Status:** Accepted
**Date:** 2026-03-13

## Context

The full tribe assembles 8 agents across 4 phases for end-to-end feature work. Many tasks do not require this level of coordination — a bug fix may only need builders and tests, a security audit may only need reviewers, and a release may only need the release engineer with a reviewer.

Running the full tribe for small changes wastes compute, adds latency from unnecessary phases, and creates idle agents that have nothing meaningful to do. At the same time, fully dynamic team composition (where the user specifies exactly which agents to spawn) adds complexity and removes the value of pre-configured, tested workflows.

The challenge is providing right-sized team configurations without an explosion of skill variants.

## Decision

Provide preset squad skills alongside the full tribe skill:

| Skill | Agents | Use Case |
| --- | --- | --- |
| `/team-up` | 8 (full tribe) | End-to-end work |
| `/team-build` | 4 (researcher + builders) | Implement |
| `/team-review` | 3 (researcher + reviewers) | Review |
| `/team-ship` | 2 (test engineer + release engineer) | Release |

Two orthogonal skills serve different purposes:

| Skill | Agents | Use Case |
| --- | --- | --- |
| `/consult` | 8 (principles guild) | Quality scoring |
| `/decide` | 2 (researcher + architect) | ADR mgmt |

Each squad skill is self-contained with its own phases, coordination rules, and task granularity guidance.

## Consequences

**What becomes easier:**

- Users can match team size to task size, reducing wasted compute and latency.
- Each squad configuration is tested and documented, not ad hoc.
- The naming convention (team-up, team-build, team-review, team-ship) makes the options discoverable and the scope of each clear.

**What becomes harder:**

- Six skills must be maintained in sync — changes to coordination rules, task granularity, or agent definitions may need to propagate across multiple skill files.
- Users must choose the right skill for their task; there is no automatic recommendation.
- Edge cases between squad boundaries (e.g., a task that needs builders and one reviewer but not all three reviewers) still require using a larger squad than strictly necessary.
