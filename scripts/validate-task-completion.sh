#!/bin/bash
# validate-task-completion.sh
#
# TaskCompleted hook: runs when a task is being marked complete.
# Exit 0 to allow completion. Exit 2 with stderr to block
# completion and send feedback.
#
# Input (stdin): JSON with task_id, task_subject,
# task_description, teammate_name, team_name, and common fields.

set -euo pipefail

INPUT=$(cat)
TASK_SUBJECT=$(echo "$INPUT" | jq -r '.task_subject // empty')
TEAMMATE_NAME=$(echo "$INPUT" | jq -r '.teammate_name // empty')

# Implementation tasks must include verification
case "$TEAMMATE_NAME" in
  backend-engineer|frontend-engineer)
    echo "Before completing '$TASK_SUBJECT':" >&2
    echo "1. Run tests for your changes" >&2
    echo "2. Check for type errors" >&2
    echo "3. Verify no regressions" >&2
    echo "" >&2
    echo "Include test results in your completion message." >&2
    exit 2
    ;;
  test-engineer)
    echo "Before completing '$TASK_SUBJECT':" >&2
    echo "1. All new tests pass" >&2
    echo "2. No existing tests broken" >&2
    echo "3. Coverage is adequate" >&2
    echo "" >&2
    echo "Include test output in your completion message." >&2
    exit 2
    ;;
  release-engineer)
    echo "Before completing '$TASK_SUBJECT':" >&2
    echo "1. All quality gates passed" >&2
    echo "2. Version bump is correct" >&2
    echo "3. Changelog is updated" >&2
    echo "" >&2
    echo "Include release checklist in completion message." >&2
    exit 2
    ;;
  *)
    exit 0
    ;;
esac
