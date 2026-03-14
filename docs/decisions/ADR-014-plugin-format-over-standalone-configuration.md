# ADR-014: Plugin Format Over Standalone Configuration

**Status:** Accepted
**Date:** 2026-03-13

## Context

AID was originally structured as a standalone `.claude/` directory layout: agents in `.claude/agents/`, skills in `.claude/skills/`, settings and hooks combined in `.claude/settings.json`. This worked for a single project but made AID impossible to distribute to other projects.

Claude Code supports a plugin system where packages can be installed via `/plugin marketplace add` and `/plugin install`. Adopting this format requires a `.claude-plugin/plugin.json` manifest, with agents, skills, hooks, and settings at the repository root rather than nested under `.claude/`.

The key forces:

- AID is intended to be reusable across any project, not tied to one repo.
- Plugin format uses `${CLAUDE_PLUGIN_ROOT}` for script paths instead of `$CLAUDE_PROJECT_DIR`, decoupling AID from the consuming project's directory.
- Hooks must be separated from settings into their own `hooks/hooks.json` file.
- Settings become environment variable declarations only.

## Decision

Convert from `.claude/` standalone layout to Claude Code plugin format:

- Add `.claude-plugin/plugin.json` as the plugin manifest with name, description, version, and author.
- Move agents from `.claude/agents/` to `agents/` at repo root.
- Move skills from `.claude/skills/` to `skills/` at repo root.
- Extract hooks from `.claude/settings.json` into `hooks/hooks.json`.
- Reduce `settings.json` to environment variable declarations only (e.g., `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`).
- Update all script references from `$CLAUDE_PROJECT_DIR` to `${CLAUDE_PLUGIN_ROOT}`.

## Consequences

**What becomes easier:**

- AID can be installed into any project via `/plugin marketplace add airshiplabs/aid` followed by `/plugin install aid`.
- Plugin versioning and distribution are handled by the Claude Code plugin ecosystem.
- Hook scripts are self-contained within the plugin, independent of the consuming project's structure.

**What becomes harder:**

- The directory layout is less intuitive for someone expecting the standard `.claude/` convention.
- Developers contributing to AID itself must understand the plugin manifest structure.
- Testing the plugin requires either installing it into a separate project or working within the plugin repo directly.
