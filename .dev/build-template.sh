#!/bin/bash
# project-template/ を毎回ゼロから組み立てるビルドスクリプト
#
# 設計方針（docs/knowledge/root-template-sync.md参照）:
# - project-template/はビルド成果物として扱い、都度作り直す（差分更新はしない）。
#   これにより「このファイルは同期対象か手動維持か」を都度判断する必要が無くなる
# - テンプレート固有の一次情報（root側に対応物が無いもの、またはroot側と役割が
#   異なるもの）は .dev/template-src/ にソースとして置く。SETUP.md、
#   docs/index.md（テンプレート版）、AGENTS.md、docs/system.md がこれに該当する
#   （AGENTS.md/docs/system.mdの分割理由はdocs/knowledge/root-template-sync.md参照）
# - rootとtemplateで内容が同一であるべきファイルは許可リスト方式でここに列挙する
# - docs/adr/ はrootのみに存在する（凍結された自プロジェクトの決定履歴）。
#   ADRは使わない方針を推奨しており、テンプレートには同梱しない
# - root自身のdocs/adr/index.mdは、ADRの新規作成をやめたため静的なファイルであり、
#   自動生成しない（生成する対象が増えることが無いため）。新たにADRを追加する
#   稀な例外が生じた場合は手動で更新する
# - zip作成は`zip`コマンド優先、無ければWindows標準のpowershell.exe（Compress-Archive）に
#   フォールバックする（Git Bashに`zip`が同梱されていないため）
set -e
BASE="$(cd "$(dirname "$0")/.." && pwd)"
TPL="$BASE/project-template"
SRC="$BASE/.dev/template-src"

# 1. project-template/ を作り直す（毎回クリーンビルド）
rm -rf "$TPL"
mkdir -p "$TPL"

# 2. テンプレート固有の一次情報（.dev/template-src/ のディレクトリ構造をそのまま反映）
cp -r "$SRC"/. "$TPL"/

# 3. rootと内容が同一であるべきファイル（許可リスト）
SHARED_FILES=(
  "CLAUDE.md"
  ".agents/skills/discussion-rules/SKILL.md"
  ".agents/skills/documentation-rules/SKILL.md"
  ".agents/skills/documentation-rules/references/document-types.md"
  ".dev/handoff-template.md"
  ".dev/index.md"
)
for f in "${SHARED_FILES[@]}"; do
  mkdir -p "$(dirname "$TPL/$f")"
  cp "$BASE/$f" "$TPL/$f"
done

# 4. zipを再作成
rm -f "$BASE/project-template.zip"
if command -v zip >/dev/null 2>&1; then
  (cd "$TPL" && zip -r "$BASE/project-template.zip" . -x '*.DS_Store' > /dev/null)
elif command -v powershell.exe >/dev/null 2>&1; then
  WIN_TPL="$(cygpath -w "$TPL")"
  WIN_ZIP="$(cygpath -w "$BASE/project-template.zip")"
  powershell.exe -NoProfile -Command "Compress-Archive -Path '${WIN_TPL}\*' -DestinationPath '${WIN_ZIP}'"
else
  echo "警告: zipもpowershell.exeも見つからないため project-template.zip を作成できなかった（project-template/ 自体は作成済み）" >&2
  exit 1
fi

echo "ビルド完了。project-template/ をゼロから再構築した。"
