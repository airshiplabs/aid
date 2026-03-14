# ADR-011: Task Granularity of 5-6 Per Teammate

**Status:** Accepted
**Date:** 2026-03-13

## Context

When assembling agent teams, work must be decomposed into tasks for each teammate. The granularity of this decomposition affects visibility, overhead, and the quality of intermediate checkpoints.

Too few tasks per teammate (1-2) creates large, opaque blocks of work with no intermediate checkpoints. If an agent goes off track early in a large task, the problem is not detected until the task completes. It also makes coordination harder because other agents cannot see progress.

Too many tasks per teammate (10+) creates excessive overhead from task management, status reporting, and transitions. Each task boundary is a potential point of context loss, and the cognitive load of tracking many small tasks outweighs the visibility benefit.

The right granularity provides enough checkpoints for visibility and course-correction without drowning in task management overhead.

## Decision

Each teammate receives 5-6 tasks per team assembly. This guideline is specified in every team skill's coordination rules section and in the project's CLAUDE.md conventions.

The 5-6 range provides:

- Enough granularity that each task is a meaningful, reviewable unit of work.
- Sufficient checkpoints for the team coordinator to detect problems early.
- A natural mapping to the typical structure of agent work: setup/context, 2-3 implementation steps, verification, and cleanup/reporting.

## Consequences

**What becomes easier:**

- Progress is visible at a glance — seeing "4 of 6 tasks complete" gives a clear picture.
- Problems are caught earlier because task boundaries force agents to produce intermediate outputs.
- Task descriptions serve as implicit documentation of the approach taken.
- Consistency across all team skills — every teammate operates at the same granularity.

**What becomes harder:**

- Some work naturally decomposes into fewer or more steps than 5-6; forcing the range can create artificial task boundaries or overly coarse groupings.
- The guideline is not enforceable — it relies on the team coordinator (the model interpreting the skill) to follow the recommendation.
- If the nature of agent work changes (e.g., agents become capable of longer autonomous runs), the optimal granularity may shift and this guideline will need revisiting across all skill files.
