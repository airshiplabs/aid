# ADR-013: Principles Guild as Dedicated Reviewers

**Status:** Accepted
**Date:** 2026-03-13

## Context

Code review through a single lens misses important trade-offs. A reviewer focused on readability may not notice performance issues; one focused on fault isolation may overlook domain modeling concerns. We wanted a review mechanism that evaluates code from multiple independent perspectives and surfaces both consensus and genuine disagreements.

The alternative was a single reviewer agent with multiple checklists — one agent cycling through simplicity, performance, fault isolation, and other lenses sequentially. This was rejected because a single agent tends to anchor on its first impression, biasing subsequent evaluations. Independent agents produce genuinely independent scores.

## Decision

We implement a Principles Guild of 8 dedicated reviewer agents, each embodying the philosophy of a legendary programmer:

| Reviewer | Lens |
| --- | --- |
| Rich Hickey | Simplicity, data orientation |
| John Carmack | Direct implementation, perf |
| Joe Armstrong | Fault isolation, resilience |
| Alan Kay | Message passing, late binding |
| Donald Knuth | Readability, maintainability |
| Barbara Liskov | Contracts, substitutability |
| Eric Evans | Domain modeling, ubiquitous language |
| John Ousterhout | Deep modules, complexity |

Each reviewer operates as an independent agent (`plan` mode, `opus` model) that reads the code and produces a 1-10 score with ranked findings citing specific files and lines.

The `/consult` skill launches all 8 in parallel, then synthesizes results into:

- A **scorecard** with all 8 scores
- **Consensus findings** — issues flagged by multiple reviewers (highest priority)
- **Top recommendations** — ranked by impact with reviewer citations
- **Dissenting views** — areas where reviewers disagree, representing genuine trade-offs

## Consequences

**What becomes easier:**

- Each review lens gets full, undivided attention from a dedicated agent rather than being one item on a checklist.
- Cross-referencing independent scores reveals true consensus: if 5 of 8 reviewers flag the same issue, it is almost certainly real.
- Dissenting views surface genuine trade-offs (e.g., Hickey wanting simplicity vs. Carmack wanting performance) that a single reviewer would resolve silently.
- The scoring format (1-10 per lens) produces a quantitative summary that is easy to compare across reviews.

**What becomes harder:**

- 8 Opus reviewer agents is expensive. A full guild consultation runs 8 parallel Opus sessions on top of any SDLC agents already active.
- The synthesis step requires the orchestrating agent to reconcile 8 independent reports, which adds latency and depends on the orchestrator's judgment.
- Adding a new reviewer requires creating an agent definition, updating the `/consult` skill, and updating CLAUDE.md — three files to keep in sync.
- The guild is designed for comprehensive review. There is no lightweight "quick check" variant — it is all 8 or none.
