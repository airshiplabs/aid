# ADR-008: Skills as Pure Templates

**Status:** Accepted
**Date:** 2026-03-13

## Context

Claude Code skills can operate in two modes: as model-interpreted prompts (where the model reads and interprets the skill text) or as pure templates (where the skill text is injected verbatim into the conversation as instructions). The difference is controlled by the `disable-model-invocation` frontmatter flag.

When a model interprets a skill, it has latitude to rephrase, reorder, or selectively apply the instructions. This flexibility can be useful for open-ended tasks but introduces non-determinism into team assembly — the same skill invocation might produce different team configurations, task assignments, or coordination rules depending on how the model interprets the text.

For AID, team assembly must be predictable. The same `/team-up` invocation should always produce the same 8 teammates with the same roles, phases, and coordination rules. Variation in team structure undermines the reliability of the workflow.

## Decision

All AID skills set `disable-model-invocation: true` in their frontmatter. Skill text is injected verbatim into the conversation as instructions rather than being interpreted by a model.

This applies to all skills: `/team-up`, `/team-build`, `/team-review`, `/team-ship`, `/consult`, and `/decide`.

## Consequences

**What becomes easier:**

- Team assembly is deterministic — the same skill always produces the same team structure.
- Skill text is the single source of truth for team configuration; what you read in the file is exactly what gets executed.
- Debugging team assembly issues is straightforward since there is no model interpretation layer to inspect.

**What becomes harder:**

- Skills cannot adapt dynamically to context — they always inject the same instructions regardless of the situation.
- Any variation in team assembly (e.g., skipping a phase, adding a teammate) requires editing the skill file or creating a new skill rather than relying on the model to adjust.
- Skill text must be more carefully authored since it will be followed literally, with no model layer to smooth over ambiguities.
