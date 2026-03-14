# ADR-015: Spotify Model Terminology

**Status:** Accepted
**Date:** 2026-03-13

## Context

The agent team was originally called "War Room" — a functional name describing a high-intensity coordination space. Subsets were unnamed or ad hoc. The principles reviewers had no collective identity.

"War Room" carries militaristic connotations that do not reflect the collaborative, creative nature of software development. More practically, the naming system lacked a coherent vocabulary for distinguishing the full team from functional subsets and cross-cutting communities.

The Spotify model provides an established organizational vocabulary that maps cleanly to AID's structure: Tribe (full cross-functional team), Squad (functional subset), and Guild (cross-cutting community of practice).

## Decision

Adopt Spotify model terminology across all agent teams and skills:

- **Tribe** = full agent team (8 agents, all SDLC phases). Replaces "War Room".
- **Squad** = functional subset. Build Squad (4 agents), Review Squad (3 agents), Ship Squad (2 agents).
- **Guild** = cross-cutting community of practice. Principles Guild (8 reviewer agents).

Specific renames:

| Old Name | New Name |
| --- | --- |
| war-room | tribe |
| war-room-build | build-squad |
| war-room-review | review-squad |
| war-room-ship | ship-squad |
| consult-the-masters | `/consult` skill, `principles-guild` team |

Action language in skills changed from "Spawn" to "Assemble" to match the organizational metaphor.

## Consequences

**What becomes easier:**

- New users immediately understand the relationship between team configurations (tribe contains squads, guild is orthogonal).
- The vocabulary is widely recognized in the software industry, reducing the learning curve.
- The naming system scales naturally if new squads or guilds are added later.

**What becomes harder:**

- Any external documentation, blog posts, or references to the original "War Room" naming become stale.
- Contributors must learn the Spotify model vocabulary to understand the naming conventions.
- The metaphor is imperfect — Spotify squads are persistent teams, while AID squads are ephemeral per-task assemblies.
