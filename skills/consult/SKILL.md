---
name: consult
description: Consult the masters — review code through the lenses of 8 legendary programmers, each scoring independently.
disable-model-invocation: true
argument-hint: "[files, PR, or description to review]"
---

# Principles Guild

Review code through 8 legendary programmer lenses.
Each guild member scores independently from their expertise.

## Phase 1: Gather Context

Identify what to review: $ARGUMENTS

- If a PR number, run `git diff` to find changed files
- If file paths, read those files directly
- If a description, use Grep/Glob to find relevant code

Read ALL relevant source files thoroughly. Each reviewer
needs the full picture to give meaningful scores.

## Phase 2: Launch Reviewers in Parallel

Create an agent team called "principles-guild" with
8 teammates, one per legendary programmer.

Spawn all 8 in parallel. Each reviewer reads the code
directly and produces a score with ranked findings.

**Shared context for every reviewer prompt:**

> You are reviewing the following code changes/files:
> $ARGUMENTS
>
> Read ALL relevant source files before forming your
> review. Report your top 5 findings ranked by impact.
> For each finding, cite the specific file and line.
> Give a score from 1-10 where 10 is perfect adherence
> to your principles.

### Teammates

1. **reviewer-hickey** — Simplicity & data orientation.
   Are concerns complected? Could plain data replace
   abstractions? Is mutable state used where immutable
   values would be clearer?

2. **reviewer-carmack** — Direct implementation &
   performance. Are there unnecessary abstractions?
   Is there a strategy to measure performance? Is
   control flow straightforward?

3. **reviewer-armstrong** — Fault isolation & resilience.
   Can one failure take down the system? Is error
   handling appropriate? Are failure domains separated?

4. **reviewer-kay** — Message passing & late binding.
   Are components autonomous? Could strategies be
   swappable? Do abstractions hold at scale?

5. **reviewer-knuth** — Readability & maintainability.
   Can a newcomer understand this? Are names precise?
   Is clarity chosen over cleverness?

6. **reviewer-liskov** — Contracts & substitutability.
   Are interfaces well-defined? Can implementations be
   swapped? Are abstraction boundaries clean?

7. **reviewer-evans** — Domain modeling & ubiquitous
   language. Does the code tell the story of the domain?
   Are bounded contexts clear? Are invariants explicit?

8. **reviewer-ousterhout** — Deep modules & complexity.
   Are modules deep with simple interfaces? Is
   complexity pulled downward? Strategic or tactical?

## Phase 3: Synthesize Scorecard

Wait for all 8 reviewers to complete. Then produce:

### Scorecard

| Reviewer | Lens | Score |
| --- | --- | --- |
| Rich Hickey | Simplicity & Data | X/10 |
| John Carmack | Directness & Perf | X/10 |
| Joe Armstrong | Fault Isolation | X/10 |
| Alan Kay | Message Passing | X/10 |
| Donald Knuth | Readability | X/10 |
| Barbara Liskov | Contracts | X/10 |
| Eric Evans | Domain Modeling | X/10 |
| John Ousterhout | Deep Modules | X/10 |
| **Average** | | **X/10** |

### Consensus Findings

Cross-reference all 8 reviews. Surface findings that
multiple reviewers flagged — these are the highest
priority items.

### Top Recommendations

Rank the top 5 actionable improvements by impact,
citing which reviewers support each recommendation.

### Dissenting Views

Note any areas where reviewers disagree — these
represent genuine trade-offs worth discussing.
