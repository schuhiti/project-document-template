#!/bin/bash
# Stop: 変更された文書にPostToolUseのper-file hookを流し直す
#
# Write|Edit以外の経路（Bashツールからのsed・python等）で書き換えた場合、
# PostToolUseのhookは発火しない。その取りこぼしをターン終了時に拾う。
# 対象を変更ファイルに絞るのは、全走査だとプロセス起動が積み上がって毎ターン
# 数秒かかるため。
# 条件は1回の編集で解消する違反に限る。作業中に常に成立する状態を条件にすると
# 鳴り続けて意味を失う（docs/knowledge/stop-hook-boundary-mismatch.md参照）。
input=$(cat)
event=$(echo "$input" | jq -r '.hook_event_name // "Stop"')
hooks="$CLAUDE_PROJECT_DIR/.claude/hooks"

cd "$CLAUDE_PROJECT_DIR" || exit 0

upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
{
  git status --porcelain 2>/dev/null | awk '{ sub(/^.../,""); if (match($0, / -> /)) $0 = substr($0, RSTART+4); print }'
  [ -n "$upstream" ] && git diff --name-only "$upstream"..HEAD 2>/dev/null
} | sort -u > /tmp/.sweep-files.$$

found=""
while IFS= read -r f; do
  [ -f "$f" ] || continue
  case "$f" in *.md) ;; *) continue ;; esac
  for h in check-frontmatter.sh check-index-sync.sh; do
    msg=$(printf '{"tool_input":{"file_path":"%s"}}' "$f" | bash "$hooks/$h" 2>&1 >/dev/null)
    [ -n "$msg" ] && found="$found
$msg"
  done
done < /tmp/.sweep-files.$$
rm -f /tmp/.sweep-files.$$

msg=$(printf '{"tool_input":{"file_path":"x.md"}}' | bash "$hooks/check-adr-orphan.sh" 2>&1 >/dev/null)
[ -n "$msg" ] && found="$found
$msg"

if [ -f .dev/handoff.md ]; then
  msg=$(printf '{"tool_input":{"file_path":".dev/handoff.md"}}' | bash "$hooks/check-handoff-length.sh" 2>&1 >/dev/null)
  [ -n "$msg" ] && found="$found
$msg"
fi

[ -z "$found" ] && exit 0

jq -n --arg event "$event" --arg body "$found" '{
  hookSpecificOutput: {
    hookEventName: $event,
    additionalContext: ("Write|Edit以外の経路で編集した文書に規約違反がある:" + $body)
  }
}'
exit 0
