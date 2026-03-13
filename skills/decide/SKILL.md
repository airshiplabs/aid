---
name: decide
description: Create, list, or update Architecture Decision Records (ADRs). The Architect researches context and writes the decision document.
disable-model-invocation: true
argument-hint: "[decision description or 'list' or 'supersede ADR-NNN']"
---

# Decision Records

Create, list, or update Architecture Decision Records
based on: $ARGUMENTS

## Operation: List

When $ARGUMENTS is "list":

Do NOT create an agent team. Instead, directly:

1. Use Glob to find all `docs/decisions/ADR-*.md` files
2. Read each file's header to extract the title (first
   heading), status, and date fields
3. Exclude ADR-000 (template)
4. Present the results sorted ascending by ADR number:

| ADR | Title | Status | Date |
| --- | ----- | ------ | ---- |

If no ADRs exist (besides the template), say so.

## Operation: Supersede

When $ARGUMENTS starts with "supersede":

Parse the ADR number and new decision description from
$ARGUMENTS (e.g., "supersede ADR-001 use MySQL instead").

Create an agent team called "decision-team" with the
following teammates:

### Supersede team structure

Spawn these 2 teammates:

1. **Researcher** — read the existing ADR being superseded.
   Gather codebase context on both the original decision
   and the new direction. Identify what has changed since
   the original ADR was written. Share findings with the
   Architect.

2. **Architect** — write the new ADR that supersedes the
   old one. Reference the original ADR in the Context
   section. Then update the old ADR's status line to
   "Superseded by ADR-NNN" where NNN is the new ADR
   number.

### Supersede workflow

- **Phase 1 — Context**: Researcher reads the existing
  ADR and gathers codebase context on the change.

- **Phase 2 — Write**: Architect creates the new ADR and
  updates the old ADR's status.

### Supersede coordination rules

- Create 3-4 tasks per teammate.
- Architect determines the next sequential ADR number by
  listing existing `docs/decisions/ADR-*.md` files.
- New ADR filename: `docs/decisions/ADR-NNN-slug.md`
  (kebab-case title, zero-padded 3 digits).
- Use today's date for the new ADR.
- New ADR status: Proposed.
- Old ADR status updated to: Superseded by ADR-NNN.
- Architect owns BOTH the new ADR file AND the old ADR
  file. Researcher owns no files.

## Operation: Create (default)

When $ARGUMENTS is any other decision description:

Create an agent team called "decision-team" with the
following teammates to document the decision: $ARGUMENTS

### Create team structure

Spawn these 2 teammates:

1. **Researcher** — explore the codebase to gather context
   relevant to the decision. Identify existing patterns,
   dependencies, constraints, and trade-offs that inform
   the decision. Share findings with the Architect.

2. **Architect** — write the ADR using the template format
   from `docs/decisions/ADR-000-template.md`. Determine
   the next sequential ADR number by listing existing
   `docs/decisions/ADR-*.md` files. Write a thorough
   Context section, a clear Decision, and honest
   Consequences.

### Create workflow

- **Phase 1 — Context**: Researcher gathers codebase
  context on the decision topic and shares findings
  with the Architect.

- **Phase 2 — Write**: Architect writes the ADR document
  based on research findings and the decision description.

### Create coordination rules

- Create 3-4 tasks per teammate.
- Architect determines the next sequential ADR number by
  listing existing `docs/decisions/ADR-*.md` files.
- ADR filename: `docs/decisions/ADR-NNN-slug.md`
  (kebab-case title, zero-padded 3 digits).
- Use today's date.
- Status: Proposed.
- Researcher owns no files. Architect owns the ADR file.
- Teammates must NOT edit the same files.
