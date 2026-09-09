#!/bin/bash
# PostToolUse(Write|Edit): .dev/handoff.md が目安（数十行）を超えたら知らせる
#
# 行数は原因ではなく指標。肥大化の原因は変化の記録や他文書との重複の混入で、
# 1行が長い形の肥大化はこの判定では捉えられない。より細かい判定を置かないのは
# 誤検出が増えるため。閾値の見直しは、長い行による弊害が実際に起きた時に行う。
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file" in
  .dev/handoff.md|*/.dev/handoff.md) ;;
  *) exit 0 ;;
esac

threshold=60
lines=$(wc -l < "$file")
[ "$lines" -le "$threshold" ] && exit 0

echo "handoff.mdが${lines}行（目安${threshold}行を超過）。変化の記録や他文書との重複が混じっていないか確認（documentation-rules参照）" >&2
exit 2
