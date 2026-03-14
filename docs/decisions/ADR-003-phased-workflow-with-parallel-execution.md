# ADR-003: Phased Workflow with Parallel Execution

**Status:** Accepted
**Date:** 2026-03-13

## Context

With 8 agents working simultaneously, we need a coordination model that balances throughput against correctness. Three approaches were considered:

- **Fully sequential**: each agent works alone, handing off to the next. Safe but extremely slow — agents sit idle most of the time.
- **Fully parallel**: all agents start at once. Fast but chaotic — builders start before design is complete, reviewers review incomplete work.
- **Hybrid phased**: sequential between phases for dependency management, parallel within phases for throughput.

The key dependencies are: builders need a design before they start, reviewers need implementation before they review, and release needs review approval before shipping.

## Decision

We use a 4-phase hybrid workflow:

- **Phase 1 — Discovery** (parallel): Researcher gathers context while Architect begins design using early findings.
- **Phase 2 — Build** (parallel): Backend Engineer, Frontend Engineer, and Test Engineer implement concurrently, each owning separate files.
- **Phase 3 — Verify** (parallel): Code Reviewer and Security Reviewer independently review all changes.
- **Phase 4 — Ship** (sequential): Release Engineer prepares and executes the release.

Phases execute sequentially. Agents within a phase execute in parallel. The `/team-up` skill orchestrates this phased execution.

## Consequences

**What becomes easier:**

- Builders always have a design to work from. Reviewers always have complete implementation to review.
- Parallel execution within phases keeps throughput high — 3 builders working simultaneously in Phase 2 is significantly faster than sequential.
- The phase structure makes progress legible: you can see which phase the team is in.

**What becomes harder:**

- Phase boundaries create synchronization points where fast agents wait for slow ones.
- If Phase 3 reviewers find blockers, fixes must route back to builders, crossing a phase boundary. This is handled by convention rather than automation.
- The rigid phase structure cannot be easily adapted for workflows where review should happen incrementally during build.
