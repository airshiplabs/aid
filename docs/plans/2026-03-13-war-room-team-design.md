# Design: War Room Agent Team (2026-03-13)

## Problem statement

Building software with a single Claude Code session limits
parallelism, creates blind spots in review, and serializes
work that could happen concurrently. A coordinated team of
specialized agents can design, build, review, and ship software
faster and with higher quality than a single session.

## Chosen approach

**War Room** — 8 specialized teammates with maximum coverage
across the full SDLC. Each agent has a distinct role, focused
tools, and appropriate permissions. The team operates with high
autonomy under a lead that coordinates work phases.

### Why War Room over alternatives

- **Pipeline** (7 agents, phased): too sequential, agents idle
  between phases
- **Studio** (6 agents, flat): good but lacks dedicated security
  and release roles
- **War Room** (8 agents, specialized): maximum coverage, every
  SDLC concern has a dedicated expert, built-in adversarial
  review

## Design details

### Team composition

| Agent              | Model | Tools          | Permission   | Memory  |
| ------------------ | ----- | -------------- | ------------ | ------- |
| Researcher         | opus  | Read-only      | plan         | project |
| Architect          | opus  | Read + Write   | plan         | project |
| Backend Engineer   | opus  | All            | acceptEdits  | project |
| Frontend Engineer  | opus  | All            | acceptEdits  | project |
| Test Engineer      | opus  | All            | acceptEdits  | project |
| Code Reviewer      | opus  | Read-only      | plan         | project |
| Security Reviewer  | opus  | Read-only      | plan         | project |
| Release Engineer   | opus  | All            | acceptEdits  | project |

### Phased workflow

```text
Phase 1 — Discovery (parallel)
  Researcher: gather context, map dependencies
  Architect: design approach, define interfaces

Phase 2 — Build (parallel)
  Backend Engineer: server-side implementation
  Frontend Engineer: client-side implementation
  Test Engineer: test writing alongside builders

Phase 3 — Verify (parallel)
  Code Reviewer: quality, correctness, maintainability
  Security Reviewer: vulnerabilities, threats, compliance

Phase 4 — Ship
  Release Engineer: version, changelog, deploy
```

### Quality gates (hooks)

- **TeammateIdle**: builders must verify tests pass before
  going idle
- **TaskCompleted**: implementation tasks require test results
  in completion message

### Skills for team operations

- `/team-up` — full team (8 teammates)
- `/team-review` — reviewers only (3 teammates)
- `/team-build` — builders only (4 teammates)
- `/team-ship` — release only (2 teammates)

## Trade-offs accepted

- **Token cost**: 8 opus agents is expensive. Accepted because
  the user prioritized quality and coverage over cost.
- **Coordination overhead**: more agents means more
  communication. Mitigated by phased workflow and file
  ownership rules.
- **Underutilization on small tasks**: some agents may be idle
  on small changes. Use subset skills (`/team-review`,
  `/team-build`) for smaller work.

## Open questions

None — design was validated and implemented.

## File structure

```text
.claude/
  agents/          (8 subagent definitions)
  skills/          (4 team operation skills)
  settings.json    (hooks configuration)
scripts/           (hook validation scripts)
CLAUDE.md          (team conventions)
docs/plans/        (this design document)
```
