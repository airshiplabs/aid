#!/bin/bash
# validate-teammate-idle.sh
#
# TeammateIdle hook: runs when a teammate is about to go idle.
# Exit 0 to allow idle. Exit 2 with stderr to send feedback
# and keep the teammate working.
#
# Input (stdin): JSON with teammate_name, team_name, and
# common fields.

set -euo pipefail

INPUT=$(cat)
TEAMMATE_NAME=$(echo "$INPUT" | jq -r '.teammate_name // empty')

# Builders must have run tests before going idle
case "$TEAMMATE_NAME" in
  backend-engineer|frontend-engineer|test-engineer)
    echo "Before going idle, confirm:" >&2
    echo "1. All tests pass for your changes" >&2
    echo "2. No type errors or lint violations" >&2
    echo "3. No unfinished tasks assigned to you" >&2
    echo "" >&2
    echo "If any of the above are incomplete, fix them now." >&2
    exit 2
    ;;
  *)
    exit 0
    ;;
esac
