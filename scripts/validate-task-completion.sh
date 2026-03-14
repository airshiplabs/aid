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

# Implementation tasks must include test evidence in the
# completion message. Check task_description for proof.
TASK_DESC=$(echo "$INPUT" | jq -r '.task_description // empty')
TEST_EVIDENCE="tests? pass|all pass|✓|0 failed|passed|test results|test output"

case "$TEAMMATE_NAME" in
  backend-engineer|frontend-engineer)
    TDD_EVIDENCE="RED:.*FAILED|GREEN:.*PASSED|REFACTOR:.*pass"
    if echo "$TASK_DESC" | grep -qiE "$TDD_EVIDENCE|$TEST_EVIDENCE"; then
      exit 0
    fi
    printf 'Before completing "%s":\n' "$TASK_SUBJECT" >&2
    echo "1. Follow TDD: write failing test → minimal code → refactor" >&2
    echo "2. Include RED/GREEN/REFACTOR evidence in completion message" >&2
    echo "3. All tests pass, no type errors" >&2
    echo "" >&2
    echo "Include TDD evidence (RED/GREEN/REFACTOR) in completion message." >&2
    exit 2
    ;;
  test-engineer)
    if echo "$TASK_DESC" | grep -qiE "$TEST_EVIDENCE"; then
      exit 0
    fi
    printf 'Before completing "%s":\n' "$TASK_SUBJECT" >&2
    echo "1. All new tests pass" >&2
    echo "2. No existing tests broken" >&2
    echo "3. Coverage is adequate" >&2
    echo "" >&2
    echo "Include test output in your completion message." >&2
    exit 2
    ;;
  release-engineer)
    RELEASE_EVIDENCE="quality gates|version bump|changelog|release checklist|ready to ship"
    if echo "$TASK_DESC" | grep -qiE "$RELEASE_EVIDENCE"; then
      exit 0
    fi
    printf 'Before completing "%s":\n' "$TASK_SUBJECT" >&2
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
