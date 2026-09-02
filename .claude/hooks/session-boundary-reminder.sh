#!/bin/bash
# PreCompact: セッション境界のリマインダーをadditionalContextでClaudeに渡す
# (stderr/stdoutのexit 0出力はデバッグログのみでClaudeに届かないため使わない)
# Stopでの運用は廃止した（docs/knowledge/stop-hook-boundary-mismatch.md参照）。
# 確認すべきものが機械的に無いと分かる場合は鳴らさない。
input=$(cat)
event=$(echo "$input" | jq -r '.hook_event_name // "PreCompact"')

cd "$CLAUDE_PROJECT_DIR" || exit 0

dirty=$(git status --porcelain 2>/dev/null)
todo_active=$(grep -c '^- \[' .dev/todo.md 2>/dev/null)

[ -z "$dirty" ] && [ "${todo_active:-0}" -eq 0 ] && exit 0

jq -n --arg event "$event" '{
  hookSpecificOutput: {
    hookEventName: $event,
    additionalContext: ".dev/handoff.md の更新、.dev/todo.md の棚卸しを確認したか（documentation-rules参照）"
  }
}'
exit 0
