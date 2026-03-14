# ADR-004: All Agents Use Opus Model

**Status:** Accepted
**Date:** 2026-03-13

## Context

Each agent definition specifies a model. Cheaper models (e.g., Sonnet) could reduce token costs for roles perceived as less critical — for instance, using Sonnet for the Researcher and reserving Opus for the Architect.

However, agent quality directly determines output quality at every stage. A weak researcher produces shallow context, leading the architect to design against incomplete information. A weak test engineer writes superficial tests that miss edge cases. The quality chain is only as strong as its weakest agent.

## Decision

Every agent uses the Opus model, with no exceptions. This applies to all 16 agents in the system: the 8 SDLC agents (Researcher, Architect, Backend Engineer, Frontend Engineer, Test Engineer, Code Reviewer, Security Reviewer, Release Engineer) and the 8 Principles Guild reviewers.

All agent definitions specify `model: opus` in their frontmatter.

## Consequences

**What becomes easier:**

- Uniform quality across all agents. No weak links in the chain.
- Simpler configuration — no need to evaluate which roles can tolerate a cheaper model.
- Every agent can handle nuanced reasoning, complex codebases, and subtle edge cases.

**What becomes harder:**

- Token costs are significantly higher. Running a full tribe with 8 Opus agents, or a guild consultation with 8 more, is expensive.
- There is no cost lever to pull when budgets are tight — the only option is to use subset skills with fewer agents.
- This decision should be revisited if future models offer Opus-level quality at lower cost.
