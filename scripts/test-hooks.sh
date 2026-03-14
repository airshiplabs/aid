#!/bin/bash
# test-hooks.sh — Tests for TDD enforcement hooks
#
# Validates that validate-teammate-idle.sh and
# validate-task-completion.sh correctly enforce TDD
# discipline for builders while allowing non-builders
# through.

set -euo pipefail

PASS=0
FAIL=0
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IDLE_SCRIPT="$SCRIPT_DIR/validate-teammate-idle.sh"
TASK_SCRIPT="$SCRIPT_DIR/validate-task-completion.sh"

run_test() {
  local name="$1" script="$2" input="$3" expected_exit="$4"
  local actual_exit=0
  local stderr_output
  stderr_output=$(echo "$input" | bash "$script" 2>&1 >/dev/null) || actual_exit=$?
  if [[ "$actual_exit" -eq "$expected_exit" ]]; then
    echo "  PASS: $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL: $name (expected exit $expected_exit, got $actual_exit)"
    echo "        stderr: $stderr_output"
    FAIL=$((FAIL + 1))
  fi
}

# Check stderr contains expected text
run_test_with_stderr() {
  local name="$1" script="$2" input="$3" expected_exit="$4" expected_stderr="$5"
  local actual_exit=0
  local stderr_output
  stderr_output=$(echo "$input" | bash "$script" 2>&1 >/dev/null) || actual_exit=$?
  if [[ "$actual_exit" -ne "$expected_exit" ]]; then
    echo "  FAIL: $name (expected exit $expected_exit, got $actual_exit)"
    echo "        stderr: $stderr_output"
    FAIL=$((FAIL + 1))
    return
  fi
  if echo "$stderr_output" | grep -qiE "$expected_stderr"; then
    echo "  PASS: $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL: $name (stderr missing expected pattern: $expected_stderr)"
    echo "        stderr: $stderr_output"
    FAIL=$((FAIL + 1))
  fi
}

echo "=== validate-teammate-idle.sh ==="
echo ""

# Test 1: Backend engineer with TDD evidence → exit 0
run_test \
  "backend-engineer with TDD evidence (RED/GREEN)" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"backend-engineer","transcript":"RED: test_create_user FAILED — expected 201 got 404\nGREEN: test_create_user PASSED"}' \
  0

# Test 2: Backend engineer without evidence → exit 2
run_test_with_stderr \
  "backend-engineer without evidence → blocked" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"backend-engineer","transcript":"I finished implementing the feature."}' \
  2 \
  "TDD evidence"

# Test 3: Frontend engineer with legacy evidence → exit 0
run_test \
  "frontend-engineer with legacy evidence (all tests pass)" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"frontend-engineer","transcript":"Ran the suite. All tests pass."}' \
  0

# Test 4: Frontend engineer without evidence → exit 2
run_test_with_stderr \
  "frontend-engineer without evidence → blocked" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"frontend-engineer","transcript":"Component renders correctly now."}' \
  2 \
  "TDD evidence"

# Test 5: Test engineer with test evidence → exit 0
run_test \
  "test-engineer with test evidence (tests pass)" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"test-engineer","transcript":"All 12 tests pass, 0 failed."}' \
  0

# Test 6: Researcher (non-builder) → exit 0
run_test \
  "researcher (non-builder) → allowed through" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"researcher","transcript":"Finished exploring the codebase."}' \
  0

# Test 7: Backend engineer with REFACTOR evidence → exit 0
run_test \
  "backend-engineer with REFACTOR evidence" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"backend-engineer","transcript":"REFACTOR: extracted helper, all tests pass"}' \
  0

# Test 8: Architect (non-builder) → exit 0
run_test \
  "architect (non-builder) → allowed through" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"architect","transcript":"Design document complete."}' \
  0

# Test 9: Test engineer without evidence → exit 2
run_test_with_stderr \
  "test-engineer without evidence → blocked" \
  "$IDLE_SCRIPT" \
  '{"teammate_name":"test-engineer","transcript":"I wrote the test file."}' \
  2 \
  "Run tests and include results"

echo ""
echo "=== validate-task-completion.sh ==="
echo ""

# Test 10: Backend engineer with TDD evidence → exit 0
run_test \
  "backend-engineer task with TDD evidence" \
  "$TASK_SCRIPT" \
  '{"task_id":"42","task_subject":"Implement user API","task_description":"RED: test_user_create FAILED\nGREEN: test_user_create PASSED\nREFACTOR: cleaned up, all tests pass","teammate_name":"backend-engineer"}' \
  0

# Test 11: Backend engineer without evidence → exit 2
run_test_with_stderr \
  "backend-engineer task without evidence → blocked" \
  "$TASK_SCRIPT" \
  '{"task_id":"42","task_subject":"Implement user API","task_description":"Added the endpoint and it works.","teammate_name":"backend-engineer"}' \
  2 \
  "TDD evidence"

# Test 12: Frontend engineer with TDD evidence → exit 0
run_test \
  "frontend-engineer task with TDD evidence" \
  "$TASK_SCRIPT" \
  '{"task_id":"43","task_subject":"Build login form","task_description":"RED: login_render FAILED — button not found\nGREEN: login_render PASSED\nAll tests pass","teammate_name":"frontend-engineer"}' \
  0

# Test 13: Frontend engineer without evidence → exit 2
run_test_with_stderr \
  "frontend-engineer task without evidence → blocked" \
  "$TASK_SCRIPT" \
  '{"task_id":"43","task_subject":"Build login form","task_description":"Form renders and submits correctly.","teammate_name":"frontend-engineer"}' \
  2 \
  "TDD evidence"

# Test 14: Test engineer with test output → exit 0
run_test \
  "test-engineer task with test output" \
  "$TASK_SCRIPT" \
  '{"task_id":"44","task_subject":"Write API tests","task_description":"Wrote 8 tests. All tests pass, 0 failed.","teammate_name":"test-engineer"}' \
  0

# Test 15: Release engineer with release checklist → exit 0
run_test \
  "release-engineer task with release checklist" \
  "$TASK_SCRIPT" \
  '{"task_id":"45","task_subject":"Ship v1.2.0","task_description":"Release checklist complete:\n- version bump done\n- changelog updated\n- quality gates passed","teammate_name":"release-engineer"}' \
  0

# Test 16: Release engineer without checklist → exit 2
run_test_with_stderr \
  "release-engineer task without checklist → blocked" \
  "$TASK_SCRIPT" \
  '{"task_id":"45","task_subject":"Ship v1.2.0","task_description":"Pushed the tag.","teammate_name":"release-engineer"}' \
  2 \
  "release checklist"

# Test 17: Code reviewer (non-builder) → exit 0
run_test \
  "code-reviewer task → allowed through" \
  "$TASK_SCRIPT" \
  '{"task_id":"46","task_subject":"Review PR","task_description":"Reviewed all changes, LGTM.","teammate_name":"code-reviewer"}' \
  0

# Test 18: Test engineer without test output → exit 2
run_test_with_stderr \
  "test-engineer task without test output → blocked" \
  "$TASK_SCRIPT" \
  '{"task_id":"44","task_subject":"Write API tests","task_description":"Created the test file with good coverage.","teammate_name":"test-engineer"}' \
  2 \
  "test output"

# Test 19: Backend engineer with legacy evidence (passed) → exit 0
run_test \
  "backend-engineer task with legacy evidence (passed)" \
  "$TASK_SCRIPT" \
  '{"task_id":"47","task_subject":"Fix auth bug","task_description":"Fixed the bug. Tests passed.","teammate_name":"backend-engineer"}' \
  0

echo ""
echo "================================"
echo "Results: $PASS passed, $FAIL failed"
echo "================================"
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
