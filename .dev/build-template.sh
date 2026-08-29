#!/bin/bash
# project-template/ を毎回ゼロから組み立てるビルドスクリプト
#
# 設計方針（docs/knowledge/root-template-sync.md参照）:
# - project-template/はビルド成果物として扱い、都度作り直す（差分更新はしない）。
#   これにより「このファイルは同期対象か手動維持か」を都度判断する必要が無くなる
# - テンプレート固有の一次情報（root側に対応物が無いもの）は .dev/template-src/ に
#   ソースとして置く。SETUP.md、docs/index.md（テンプレート版）がこれに該当する
# - rootとtemplateで内容が同一であるべきファイルは許可リスト方式でここに列挙する
# - docs/adr/ はrootのみに存在する（凍結された自プロジェクトの決定履歴）。
#   ADRは使わない方針を推奨しており、テンプレートには同梱しない
# - root自身のdocs/adr/index.mdは、ADRの新規作成をやめたため静的なファイルであり、
#   自動生成しない（生成する対象が増えることが無いため）。新たにADRを追加する
#   稀な例外が生じた場合は手動で更新する
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
  "AGENTS.md"
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
cd "$TPL"
zip -r "$BASE/project-template.zip" . -x '*.DS_Store' > /dev/null

echo "ビルド完了。project-template/ をゼロから再構築した。"
