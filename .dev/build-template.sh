#!/bin/bash
# project-template/ を毎回ゼロから組み立てるビルドスクリプト
#
# 設計方針（docs/knowledge/root-template-sync.md参照）:
# - project-template/はビルド成果物として扱い、都度作り直す（差分更新はしない）。
#   これにより「このファイルは同期対象か手動維持か」を都度判断する必要が無くなる
# - テンプレート固有の一次情報（root側に対応物が無いもの、またはroot側と役割が
#   異なるもの）は .dev/template-src/ にソースとして置く。SETUP.md、
#   docs/index.md（テンプレート版）、AGENTS.md、docs/system.md、.claude/settings.json
#   がこれに該当する（AGENTS.md/docs/system.mdの分割理由はdocs/knowledge/root-template-sync.md参照。
#   .claude/settings.jsonはroot版がStop/PreCompactのhookも含み中身が異なるため
#   ここに置く。参照先のhookスクリプト自体（.claude/hooks/*.sh）は中身が同一
#   なのでSHARED_FILESに列挙する）
# - rootとtemplateで内容が同一であるべきファイルは許可リスト方式でここに列挙する
# - docs/adr/ はrootのみに存在する（凍結された自プロジェクトの決定履歴）。
#   ADRは使わない方針を推奨しており、テンプレートには同梱しない
# - root自身のdocs/adr/index.mdは、ADRの新規作成をやめたため静的なファイルであり、
#   自動生成しない（生成する対象が増えることが無いため）。新たにADRを追加する
#   稀な例外が生じた場合は手動で更新する
# - zip作成は`zip`コマンド優先、無ければWindows標準のpowershell.exeに
#   フォールバックする（Git Bash/WSLどちらにも`zip`が同梱されていないため）。powershell.exeは
#   PATH上に無い場合の既定インストール先も試し、Windows側パスへの変換はcygpath（Git Bash）・
#   wslpath（WSL）のどちらか使える方を使う。zip作成には`Compress-Archive`ではなく.NETの
#   `System.IO.Compression.ZipFile`を直接使う（`PSModulePath`が空の環境でCompress-Archiveの
#   モジュール自動読み込みに失敗する事例があったため。原因はWSL経由の呼び出しに限らない可能性がある）
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
  ".claude/hooks/check-frontmatter.sh"
  ".claude/hooks/check-handoff-length.sh"
  ".claude/hooks/check-index-sync.sh"
  ".claude/setup-skills.sh"
)
for f in "${SHARED_FILES[@]}"; do
  mkdir -p "$(dirname "$TPL/$f")"
  cp "$BASE/$f" "$TPL/$f"
done

# 4. zipを再作成
rm -f "$BASE/project-template.zip"
PWSH="$(command -v powershell.exe 2>/dev/null || true)"
if [ -z "$PWSH" ] && [ -x "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" ]; then
  # WSLではinterop設定次第でpowershell.exeがPATHに無いことがあるため、既定インストール先も試す
  PWSH="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"
fi
if command -v zip >/dev/null 2>&1; then
  (cd "$TPL" && zip -r "$BASE/project-template.zip" . -x '*.DS_Store' > /dev/null)
elif [ -n "$PWSH" ]; then
  if command -v cygpath >/dev/null 2>&1; then
    TOWIN() { cygpath -w "$1"; }
  elif command -v wslpath >/dev/null 2>&1; then
    TOWIN() { wslpath -w "$1"; }
  else
    echo "警告: パス変換ツール(cygpath/wslpath)が見つからないため project-template.zip を作成できなかった（project-template/ 自体は作成済み）" >&2
    exit 1
  fi
  WIN_TPL="$(TOWIN "$TPL")"
  WIN_ZIP="$(TOWIN "$BASE/project-template.zip")"
  "$PWSH" -NoProfile -Command "Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::CreateFromDirectory('${WIN_TPL}', '${WIN_ZIP}')"
else
  echo "警告: zipもpowershell.exeも見つからないため project-template.zip を作成できなかった（project-template/ 自体は作成済み）" >&2
  exit 1
fi

echo "ビルド完了。project-template/ をゼロから再構築した。"
