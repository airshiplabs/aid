---
name: team-review
description: Spawn a review-focused agent team with code reviewer and security reviewer for thorough PR or code review.
disable-model-invocation: true
argument-hint: "[PR number or description]"
---

# War Room: Review Team

Create an agent team called "war-room-review" with the
following teammates to review: $ARGUMENTS

## Team structure

Spawn these 3 teammates:

1. **Researcher** — explore the changes and gather context.
   Run `git diff` to identify all changed files. Map the
   impact of changes across the codebase. Report findings
   to the reviewers.

2. **Code Reviewer** — review all changes for quality,
   correctness, and maintainability. Check that tests
   cover the changed behavior. Use Conventional Comments
   format for feedback.

3. **Security Reviewer** — review all changes for
   vulnerabilities, insecure patterns, and compliance
   issues. Check dependencies for known CVEs. Provide
   severity-rated findings.

## Workflow

- **Phase 1 — Context**: Researcher gathers context on
  the changes and shares findings with both reviewers.

- **Phase 2 — Review**: Code Reviewer and Security
  Reviewer work in parallel. Each applies their own
  lens to the same changes.

- **Phase 3 — Synthesize**: Lead combines findings from
  both reviewers into a unified review summary with
  all blockers, issues, and suggestions.

## Output

Produce a structured review with:

- **Blockers**: must fix before merge
- **Issues**: should fix, significant concerns
- **Suggestions**: optional improvements
- **Security findings**: with severity ratings
- **Overall verdict**: approve, request changes, or block
