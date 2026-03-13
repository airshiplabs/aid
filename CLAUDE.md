# AID — Airship Intelligence Division

## Team overview

This project uses a **War Room** agent team architecture with
8 specialized agents that cover the full software development
lifecycle: research, design, build, review, and ship.

## Agents

| Agent              | Role                         | Mode        |
| ------------------ | ---------------------------- | ----------- |
| Researcher         | Codebase exploration         | Read-only   |
| Architect          | System design                | Read-only   |
| Backend Engineer   | Server-side implementation   | Edit        |
| Frontend Engineer  | Client-side implementation   | Edit        |
| Test Engineer      | Test writing and coverage    | Edit        |
| Code Reviewer      | Quality and correctness      | Read-only   |
| Security Reviewer  | Vulnerabilities and threats  | Read-only   |
| Release Engineer   | Shipping and deployment      | Edit        |

Agent definitions live in `.claude/agents/`.

## Skills

| Skill          | Purpose                               |
| -------------- | ------------------------------------- |
| `/team-up`     | Spawn full War Room (8 teammates)     |
| `/team-review` | Spawn review team (3 teammates)       |
| `/team-build`  | Spawn build team (4 teammates)        |
| `/team-ship`   | Spawn ship team (2 teammates)         |

Skill definitions live in `.claude/skills/`.

## Hooks

Quality gates enforced via hooks in `.claude/settings.json`:

- **TeammateIdle** — builders must verify tests pass before
  going idle
- **TaskCompleted** — implementation tasks require test
  results in their completion message

Hook scripts live in `scripts/`.

## Workflow

The standard workflow for feature work:

```text
/team-up "implement feature X"
```

This spawns the full team with phased work:

1. **Discovery** — Researcher + Architect (parallel)
2. **Build** — Backend + Frontend + Test (parallel)
3. **Verify** — Code Reviewer + Security Reviewer (parallel)
4. **Ship** — Release Engineer

## Conventions

- Teammates must NOT edit the same files
- Create 5-6 tasks per teammate
- Reviewers use Conventional Comments format
- Builders run tests before marking tasks complete
- File ownership is assigned explicitly in tasks
- All agents use the Opus model
