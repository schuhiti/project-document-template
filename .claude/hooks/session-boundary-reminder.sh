#!/bin/bash
# Stop / PreCompact: セッション境界のリマインダーをadditionalContextでClaudeに渡す
# (stderr/stdoutのexit 0出力はデバッグログのみでClaudeに届かないため使わない)
input=$(cat)
event=$(echo "$input" | jq -r '.hook_event_name // "Stop"')

jq -n --arg event "$event" '{
  hookSpecificOutput: {
    hookEventName: $event,
    additionalContext: ".dev/handoff.md の更新、.dev/todo.md の棚卸しを確認したか（documentation-rules参照）"
  }
}'
exit 0
