#!/bin/bash
# PostToolUse(Write|Edit): docs/**.md に type frontmatter が無ければ知らせる
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file" in
  docs/*.md|*/docs/*.md) ;;
  *) exit 0 ;;
esac

if head -n 1 "$file" | grep -q '^---$' && grep -q '^type:' "$file"; then
  exit 0
fi

echo "frontmatterに type が無い: $file（documentation-rules参照）" >&2
exit 2
