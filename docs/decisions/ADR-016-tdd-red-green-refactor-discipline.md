# ADR-016: TDD Red-Green-Refactor Discipline

**Status:** Proposed
**Date:** 2026-03-13

## Context

Builder agents (Backend Engineer, Frontend Engineer) follow an "implement first, test after" workflow. In both agent definitions, steps 3-4 are implementation and steps 5-6 are testing. The existing quality gate hooks (ADR-007) only verify that tests *passed* — they never check that tests were written *first* or that the TDD cycle was followed.

The Test Engineer is positioned reactively ("understand what was implemented or needs testing"), writing tests alongside or after builders rather than driving the development cycle.

This ordering means tests confirm existing code rather than drive design. Tests written after implementation tend to mirror the implementation rather than specify behavior, producing weaker coverage and missing edge cases that test-first thinking would catch.

TDD red-green-refactor is a well-established discipline that inverts this order: write a failing test first (RED), write minimal code to pass (GREEN), then improve the code while keeping tests green (REFACTOR). This produces tests that specify intent, minimal implementations, and code that is safe to refactor.

## Decision

Adopt TDD red-green-refactor as the mandatory workflow for all builder agents. Enforce through two layers:

**Agent definitions** instruct builders to follow the TDD cycle. The "When invoked" workflow changes from "implement then test" to:

1. Review the spec
2. Understand existing code
3. Write a failing test (RED)
4. Run it, confirm failure for the right reason
5. Write minimal code to pass (GREEN)
6. Run tests, confirm all pass
7. Refactor while green (REFACTOR)
8. Repeat for each unit of functionality

A new "TDD discipline" section states the iron law — no production code without a failing test first — and defines the structured evidence format agents must include in task completion messages:

- `RED: <test_name> FAILED — <reason>`
- `GREEN: <test_name> PASSED — all N tests pass`
- `REFACTOR: <what changed> — all N tests still pass`

**Quality gate hooks** add TDD evidence detection alongside existing test-pass patterns. Both `validate-teammate-idle.sh` and `validate-task-completion.sh` expand their evidence regex to include `RED:.*FAILED|GREEN:.*PASSED|REFACTOR:.*pass`, joined with existing patterns via OR matching. This means legacy evidence ("tests pass", "all pass", etc.) still satisfies the hooks, preventing rejection loops during adoption.

The Test Engineer shifts from primary test author to test strategist — supplementing builder-written TDD tests with integration tests, edge case coverage, and coverage gap analysis. Builders own their own TDD cycle because TDD works best when the same person writes the test and the implementation.

No new hook events are added. No changes to `hooks.json` wiring.

## Consequences

**What becomes easier:**

- Tests specify intent before code exists, producing stronger behavioral coverage and catching design issues earlier.
- The structured RED/GREEN/REFACTOR evidence format creates an audit trail showing TDD discipline was followed, visible to code reviewers and in task completion messages.
- Builders think about interface design and edge cases upfront (when writing the test) rather than retroactively.
- The Test Engineer can focus on higher-value work — integration tests, coverage analysis, test strategy — rather than duplicating unit tests builders should own.
- OR matching for hook evidence provides a graceful adoption path with no rejection loops.

**What becomes harder:**

- Builder agents have more steps per unit of work — writing and running the test before implementation adds overhead to each cycle.
- Agents may rationalize skipping TDD ("I already know what to write"). The prompt-level enforcement helps but cannot guarantee compliance in all cases.
- The Test Engineer's role requires clearer task descriptions to distinguish "write integration tests" from "write all the tests."
- Hook evidence detection is still regex-based and could produce false positives if an agent's output accidentally matches the pattern without actually following TDD.
- Strict enforcement (requiring TDD evidence AND test-pass evidence) is deferred — the current OR matching means an agent could technically satisfy hooks without TDD markers.
