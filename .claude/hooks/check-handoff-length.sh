#!/bin/bash
# PostToolUse(Write|Edit): .dev/handoff.md が目安（数十行）を超えたら知らせる
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file" in
  .dev/handoff.md|*/.dev/handoff.md) ;;
  *) exit 0 ;;
esac

threshold=60
lines=$(wc -l < "$file")
[ "$lines" -le "$threshold" ] && exit 0

echo "handoff.mdが${lines}行（目安${threshold}行を超過）。定住先へ移せる節が無いか確認（documentation-rules参照）" >&2
exit 2
