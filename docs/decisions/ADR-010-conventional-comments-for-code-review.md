# ADR-010: Conventional Comments for Code Review

**Status:** Accepted
**Date:** 2026-03-13

## Context

Code review feedback from multiple agent reviewers (Code Reviewer, Security Reviewer, and the 8 Principles Guild members) needs to be actionable and prioritizable. Without a structured format, review output becomes a wall of prose where critical issues are buried alongside minor style preferences.

Developers receiving review feedback need to quickly answer: What must I fix before merge? What should I fix but can defer? What is optional?

Conventional Comments is an established format that provides severity labels, making triage immediate. It was designed for human code review but maps well to agent-generated feedback.

## Decision

All reviewer agents must use Conventional Comments format with six severity levels:

| Level | Meaning |
| --- | --- |
| **blocker** | Must fix before merge |
| **issue** | Should fix, significant concern |
| **suggestion** | Optional improvement |
| **nitpick** | Style or preference, non-blocking |
| **question** | Clarification needed |
| **praise** | Something done well |

Each finding must include:

1. The severity label
2. The specific file and line
3. What is wrong and why
4. A concrete suggestion for how to fix it

This format is enforced in the Code Reviewer and Security Reviewer agent definitions and referenced in the Principles Guild skill.

## Consequences

**What becomes easier:**

- Review feedback is immediately triageable — blockers surface first, nitpicks last.
- Multiple reviewers' feedback can be merged and deduplicated by severity.
- Builders know exactly what requires action and what is informational.
- The format is familiar to developers who already use Conventional Comments in human reviews.

**What becomes harder:**

- Reviewers must fit all feedback into the six-level taxonomy, which may feel forced for nuanced observations.
- The structured format adds verbosity compared to a brief "this looks wrong" comment.
- Praise items, while valuable for morale, add noise when scanning for actionable issues.
