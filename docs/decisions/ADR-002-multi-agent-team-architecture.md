# ADR-002: Multi-Agent Team Architecture

**Status:** Accepted
**Date:** 2026-03-13

## Context

Building software with a single Claude Code session serializes work, limits parallelism, and creates blind spots in review. We needed a multi-agent architecture that covers the full software development lifecycle with dedicated expertise at every stage.

Three team structures were considered:

- **Pipeline** (7 agents, sequential phases): every SDLC stage has an agent, but agents idle between phases, wasting capacity on long builds.
- **Studio** (6 agents, flat): good parallelism, but lacks dedicated security review and release engineering roles, leaving gaps in the SDLC.
- **Tribe** (8 agents, 4 squads): maximum coverage with a dedicated expert for every concern and built-in adversarial review from independent reviewers.

## Decision

We adopt a Tribe architecture with 8 specialized agents organized into squads:

1. **Researcher** — codebase exploration and context gathering
2. **Architect** — system design, module boundaries, ADR ownership
3. **Backend Engineer** — server-side implementation
4. **Frontend Engineer** — client-side implementation
5. **Test Engineer** — test writing and coverage
6. **Code Reviewer** — quality, correctness, maintainability review
7. **Security Reviewer** — vulnerability and compliance review
8. **Release Engineer** — versioning, changelog, deployment

Each agent has a focused role, scoped tools, and appropriate permission levels. The team is assembled via skills (`/team-up` for the full tribe, subset skills for smaller work).

## Consequences

**What becomes easier:**

- Every SDLC concern has a dedicated expert, reducing blind spots.
- Independent Code Reviewer and Security Reviewer provide adversarial review that catches issues builders miss.
- Subset skills (`/team-build`, `/team-review`, `/team-ship`) allow right-sizing the team to the task.

**What becomes harder:**

- 8 agents is expensive in token cost. This is an explicit quality-over-cost trade-off.
- Coordination overhead increases with team size. Mitigated by phased workflow (ADR-003) and file ownership rules (ADR-006).
- Small tasks may underutilize agents. Subset skills exist for this, but the user must choose the right one.
