#!/bin/bash
# PostToolUse(Write|Edit): 同ディレクトリにindex.mdがあれば、書き込んだ.mdがそこにリンクされているか確認
# (逆方向 = index.md内の死リンク検出はしない。削除はEditツールを通らないため対象外)
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file" in
  *.md) ;;
  *) exit 0 ;;
esac

dir=$(dirname "$file")
index="$dir/index.md"
[ -f "$index" ] || exit 0

name=$(basename "$file")
[ "$name" = "index.md" ] && exit 0

grep -qF "]($name)" "$index" && exit 0

echo "index.mdに未掲載: $name（$index に1行追加）" >&2
exit 2
