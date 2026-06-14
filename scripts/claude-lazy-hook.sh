#!/usr/bin/env bash
# PostToolUse hook: regenerate lazy-lock.json when Claude edits a plugin spec.
# Receives the hook event as JSON on stdin; exits 0 immediately for unrelated files.
set -euo pipefail

# Extract file_path from hook JSON. Handles both Edit/Write (top-level file_path)
# and MultiEdit (edits[0].file_path).
file=$(python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    ti = d.get('tool_input', {})
    # Edit / Write: top-level file_path
    path = ti.get('file_path', '')
    # MultiEdit: edits array
    if not path:
        edits = ti.get('edits', [])
        path = edits[0].get('file_path', '') if edits else ''
    print(path)
except Exception:
    pass
" 2>/dev/null)

case "$file" in
    */nvim/lua/plugins/*.lua|*/nvim/lua/config/lazy.lua)
        exec "$(git rev-parse --show-toplevel)/scripts/lazy-sync.sh"
        ;;
esac
