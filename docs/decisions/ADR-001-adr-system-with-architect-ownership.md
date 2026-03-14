# ADR-001: ADR System with Architect Ownership

**Status:** Accepted
**Date:** 2026-03-13

## Context

As AID evolves, significant architectural decisions are made during tribe workflows — design choices, technology selections, trade-off evaluations — that are not captured anywhere persistent. Without a record, future contributors (human or agent) lack the context behind decisions and risk revisiting settled questions or unknowingly violating constraints.

Architecture Decision Records (ADRs) are a lightweight, widely-adopted format for capturing these decisions with their context and consequences. The question was: who owns ADR creation in a multi-agent team, and when should ADRs be evaluated?

Allowing any agent to write ADRs risks inconsistent quality, duplicate records, and file conflicts (since agents must not edit the same files). A single owner with clear criteria and evaluation points provides consistency and prevents coordination problems.

## Decision

The Architect agent is the sole owner of ADR documentation:

- Only the Architect writes files in `docs/decisions/`.
- No other teammate creates, modifies, or supersedes ADRs.
- The Architect evaluates whether decisions warrant ADRs at the end of each phase in `/team-up`: Discovery, Build, Verify, and Ship.

ADR criteria (write an ADR when a decision):

- Constrains future implementation choices
- Involves trade-offs that should be recorded
- Affects multiple components or team members
- Would be questioned by a future developer without context

Anti-criteria (do NOT write an ADR for):

- Trivial implementation details
- Easily reversible decisions
- Standard patterns with no meaningful alternatives

A `/decide` skill supports standalone ADR operations: create, list, and supersede.

## Consequences

**What becomes easier:**

- Decisions are documented consistently in a single voice with uniform quality.
- File ownership is clear — no merge conflicts on ADR files between agents.
- Phase-based evaluation ensures decisions are captured near when they are made, not forgotten.
- The `/decide` skill allows ADR creation outside of full tribe workflows.

**What becomes harder:**

- The Architect becomes a bottleneck for ADR documentation — if the Architect agent misses a decision, it goes unrecorded.
- Builders and reviewers cannot directly document decisions they discover during their work; they must rely on the Architect noticing.
- The phase-end evaluation points add overhead to every tribe workflow, even when no ADRs are warranted.
