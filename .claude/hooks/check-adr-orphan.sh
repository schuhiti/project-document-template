#!/bin/bash
# PostToolUse(Write|Edit): docs/adr/ の記録が生きた文書から指されているか確認
#
# 対象は日付+スラッグ名のファイルのみ。連番名のADRは、連番運用をやめる前に
# 書かれ、生きた文書から意図的に参照を外してあるため対象外。
# 探索先から handoff・todo・scratch・索引を除くのは、どれも書き換え・削除で
# 消えるため到達経路として数えないという規則による（documentation-rules
# 「経緯への到達経路」参照）。
# 探索対象をgitの管理下（追跡済み + ignoreされていない未追跡）に限るのは、
# ディレクトリを再帰的に走査すると、対象数がビルド成果物や依存ライブラリの
# 規模に応じて増えるため。
# 差分から「ポインタを消した編集」を捉えるのではなく毎回全走査するのは、
# 編集前の状態を持たずに済み、対象が数十ファイルの規模では差が出ないため。
input=$(cat)
file=$(echo "$input" | jq -r '.tool_input.file_path // empty')

case "$file" in
  *.md|*.sh) ;;
  *) exit 0 ;;
esac

root="${CLAUDE_PROJECT_DIR:-.}"
adr_dir="$root/docs/adr"
[ -d "$adr_dir" ] || exit 0

sources=$(git -C "$root" ls-files --cached --others --exclude-standard -- '*.md' '*.sh' 2>/dev/null \
  | grep -v -e '^docs/adr/' -e '^\.dev/scratch/' \
            -e '/handoff\.md$' -e '/todo\.md$' -e '/index\.md$')

[ -n "$sources" ] || exit 0
corpus=$(cd "$root" && cat $sources 2>/dev/null)

orphans=""
for f in "$adr_dir"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-*.md; do
  [ -e "$f" ] || continue
  grep -q '^到達経路: 索引のみ' "$f" && continue
  name=$(basename "$f")
  case "$corpus" in
    *"$name"*) ;;
    *) orphans="$orphans $name" ;;
  esac
done

[ -n "$orphans" ] || exit 0

echo "生きた文書から指されていない決定の記録:$orphans" >&2
echo "退役したのか、ポインタを張り忘れたのか、もともと反映先が無いのかを判断する。" >&2
echo "反映先が無いと確定しているなら、その記録に「到達経路: 索引のみ（理由）」の行を足す。" >&2
exit 2
