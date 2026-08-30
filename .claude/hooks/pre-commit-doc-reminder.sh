#!/bin/bash
# PreToolUse(Bash): git commit実行前、文書規約対象の.mdがステージされていれば
# diffで文章構造の原則(documentation-rules)を確認したかリマインドする(非ブロッキング)
input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

echo "$command" | grep -qE '(^|;|&&|\|)\s*git commit' || exit 0

cd "$CLAUDE_PROJECT_DIR" || exit 0
files=$(git diff --cached --name-only -- '*.md' | grep -v '^project-template/')
[ -z "$files" ] && exit 0

echo "[pre-commit] 文章構造の原則(documentation-rules)を満たしているか、diffを確認したか:" >&2
echo "$files" | sed 's/^/  /' >&2
exit 0
