# ADR-012: Shared First Principles Across Agents

**Status:** Accepted
**Date:** 2026-03-13

## Context

With 8 SDLC agents working on the same codebase, inconsistent quality standards create friction. If the Backend Engineer optimizes for performance while the Frontend Engineer prioritizes readability, their code feels like it was written by different teams with different values. A shared set of principles ensures every agent applies the same quality bar.

The challenge is that Claude Code agent definitions are standalone Markdown files with no include or inheritance mechanism. Shared content must be duplicated across files.

## Decision

We embed 8 common first principles directly in every SDLC agent definition under a "First principles" section:

1. **Clarity over cleverness** — write for humans to read first, machines to execute second
2. **Strong boundaries, loose coupling** — define interfaces clearly; communicate minimally
3. **Fail fast, fail loud** — detect errors early; never silently mask problems
4. **Automate the repetitive, measure the critical** — automate builds, tests, deploys; measure system health and business impact
5. **Design for change** — expect requirements, dependencies, and scale to evolve
6. **Test at the right levels** — unit for correctness, integration for contracts, e2e for outcomes
7. **Simplicity wins** — fewer moving parts, fewer bugs, easier onboarding, faster recovery
8. **Operational excellence is a feature** — observability, alerting, and easy recovery are part of the design

These principles are identical across 7 agent files. The Researcher is intentionally excluded because its role is exploratory — it gathers context and maps the codebase but does not produce artifacts judged against quality principles. Each agent also has role-specific implementation guidance that builds on top of these shared principles.

## Consequences

**What becomes easier:**

- All agents share a common quality vocabulary. A Code Reviewer can cite the same principles the Backend Engineer was instructed to follow.
- Onboarding new agent definitions is straightforward — copy the principles block and add role-specific guidance.
- Principles align with the project's CLAUDE.md, creating consistency between human and agent standards.

**What becomes harder:**

- The principles are duplicated across 7 agent files. A change to one principle requires updating all files manually.
- There is no mechanism to detect drift — if one agent's copy diverges from the others, the inconsistency is silent.
- The duplication adds roughly 20 lines to every agent definition, increasing file size without adding role-specific value.
