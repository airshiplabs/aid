---
name: team-up
description: Assemble the full tribe — all squads working together for end-to-end feature work. Includes researcher, architect, builders, reviewers, and release engineer.
disable-model-invocation: true
argument-hint: "[task description]"
---

# Tribe: Full Squad Assembly

Create an agent team called "tribe" with the following
teammates and assign them tasks for: $ARGUMENTS

## Team structure

Spawn these 8 teammates with these roles:

1. **Researcher** — explore the codebase to gather context,
   map dependencies, and identify constraints relevant to
   the task. Report findings to the team.

2. **Architect** — design the approach based on research
   findings. Define module boundaries, interface contracts,
   and the implementation plan. Get plan approved before
   builders start.

3. **Backend Engineer** — implement server-side changes:
   APIs, data models, business logic, infrastructure.
   Own backend files only.

4. **Frontend Engineer** — implement client-side changes:
   UI components, user interactions, state management.
   Own frontend files only.

5. **Test Engineer** — write tests alongside the builders.
   Cover happy paths, edge cases, and error paths.
   Own test files only.

6. **Code Reviewer** — review all implementation work for
   quality, correctness, and maintainability. Use
   Conventional Comments format.

7. **Security Reviewer** — review all implementation work
   for vulnerabilities, insecure patterns, and compliance
   issues. Provide severity-rated findings.

8. **Release Engineer** — once review is complete, prepare
   the release: version bump, changelog, and deployment.

## Workflow

Phase the work as follows:

- **Phase 1 — Discovery**: Researcher and Architect work
  in parallel. Researcher gathers context, Architect
  begins design using early findings.

- **Phase 2 — Build**: Backend Engineer, Frontend Engineer,
  and Test Engineer work in parallel. Each owns separate
  files to avoid conflicts.

- **Phase 3 — Verify**: Code Reviewer and Security Reviewer
  work in parallel reviewing all changes.

- **Phase 4 — Ship**: Release Engineer prepares and
  executes the release.

## Coordination rules

- Teammates must NOT edit the same files. Assign file
  ownership explicitly in tasks.
- Create 5-6 tasks per teammate for steady progress.
- Wait for teammates to complete before synthesizing.
- If a reviewer finds blockers, route fixes back to the
  appropriate builder.
