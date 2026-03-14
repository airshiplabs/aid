# AID — Airship Intelligence Division

A Claude Code **plugin** with agent teams that ship high-quality software, faster.

## Installation

```text
/plugin marketplace add airshiplabs/aid
/plugin install aid
```

## Plugin Structure

```text
.claude-plugin/plugin.json   Plugin manifest
agents/                      16 agent definitions
skills/                      6 skills
hooks/hooks.json             Quality gate hooks
scripts/                     Hook validation scripts
settings.json                Plugin settings
```

## SDLC Agents

| Agent              | Role                       | Mode      |
| ------------------ | -------------------------- | --------- |
| Researcher         | Codebase exploration       | Read-only |
| Architect          | System design              | Plan      |
| Backend Engineer   | Server-side implementation | Edit      |
| Frontend Engineer  | Client-side implementation | Edit      |
| Test Engineer      | Test writing and coverage  | Edit      |
| Code Reviewer      | Quality and correctness    | Read-only |
| Security Reviewer  | Vulnerabilities and threats| Read-only |
| Release Engineer   | Shipping and deployment    | Edit      |

## Principles Guild

| Guild Member     | Lens                       |
| ---------------- | -------------------------- |
| Rich Hickey      | Simplicity & data          |
| John Carmack     | Directness & performance   |
| Joe Armstrong    | Fault isolation            |
| Alan Kay         | Message passing            |
| Donald Knuth     | Readability                |
| Barbara Liskov   | Contracts & substitution   |
| Eric Evans       | Domain modeling            |
| John Ousterhout  | Deep modules & complexity  |

Agent definitions live in `agents/`.

## Skills

| Skill          | Purpose                           |
| -------------- | --------------------------------- |
| `/team-up`     | Assemble full tribe (8 teammates) |
| `/team-review` | Assemble review squad (3)         |
| `/team-build`  | Assemble build squad (4)          |
| `/team-ship`   | Assemble ship squad (2)           |
| `/consult`     | Convene principles guild (8)      |
| `/decide`      | Create or manage ADRs (decisions) |

Skill definitions live in `skills/`.

## Hooks

Quality gates enforced via hooks in `hooks/hooks.json`:

- **TeammateIdle** — builders must verify tests pass before going idle
- **TaskCompleted** — implementation tasks require test results in their completion message

Hook scripts live in `scripts/`.

## Workflow

The standard workflow for feature work:

```text
/team-up "implement feature X"
```

This assembles the full tribe with phased work:

1. **Discovery** — Researcher + Architect (parallel)
2. **Build** — Backend + Frontend + Test (parallel)
3. **Verify** — Code Reviewer + Security Reviewer (parallel)
4. **Ship** — Release Engineer

## TDD Discipline

Builder agents (Backend Engineer, Frontend Engineer, Test Engineer) follow
**red-green-refactor** discipline:

1. **RED** — Write a failing test first
2. **GREEN** — Write minimal code to make it pass
3. **REFACTOR** — Clean up while keeping tests green

Hook scripts enforce this by requiring TDD evidence (test output showing
RED→GREEN transitions) before builders can go idle or complete tasks.

## Conventions

- Teammates must NOT edit the same files
- Create 5-6 tasks per teammate
- Reviewers use Conventional Comments format
- Builders follow TDD red-green-refactor and provide test evidence
- File ownership is assigned explicitly in tasks
- All agents use the Opus model
