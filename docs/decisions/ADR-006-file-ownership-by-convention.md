# ADR-006: File Ownership by Convention

**Status:** Accepted
**Date:** 2026-03-13

## Context

During Phase 2 (Build), three agents — Backend Engineer, Frontend Engineer, and Test Engineer — work in parallel. If two agents edit the same file concurrently, one agent's changes silently overwrite the other's, or both produce inconsistent modifications to shared code.

Several approaches to preventing conflicts were considered:

- **File locking**: agents acquire locks before editing. Adds complexity, deadlock risk, and requires a lock manager.
- **Merge-based resolution**: agents edit freely, conflicts resolved by merge. Requires sophisticated merge tooling and may produce incorrect merges.
- **Sequential editing**: only one builder works at a time. Safe but eliminates parallelism, defeating the purpose of multiple builders.
- **Convention-based ownership**: explicitly assign which files each agent owns in task descriptions. Simple, no tooling required.

## Decision

File ownership is assigned by convention: task descriptions explicitly state which files each builder agent owns, and agents must not edit files outside their assignment. The rule is stated in the `/team-up` skill and CLAUDE.md:

> Teammates must NOT edit the same files. Assign file ownership explicitly in tasks.

Ownership is typically divided along natural boundaries: backend files to Backend Engineer, frontend files to Frontend Engineer, test files to Test Engineer. The orchestrating agent is responsible for making clean assignments when creating tasks.

## Consequences

**What becomes easier:**

- Zero tooling required — the convention is enforced by agent instructions alone.
- Clean separation encourages well-factored code with clear module boundaries.
- No deadlocks, no lock managers, no merge resolution logic.

**What becomes harder:**

- Enforcement is soft: there is no runtime check preventing an agent from editing a file it does not own. A sufficiently confused agent could violate the rule.
- Cross-cutting changes that touch both backend and frontend files require careful coordination in task assignment.
- The orchestrating agent must understand the codebase well enough to make clean ownership splits. Ambiguous boundaries (e.g., shared utility files) require judgment.
