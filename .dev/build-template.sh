#!/bin/bash
# project-template/ を毎回ゼロから組み立てるビルドスクリプト
#
# 構成: docs/knowledge/root-template-sync.md
# 経緯: docs/adr/2026-08-30-template-build-from-source.md
#
# hookの配布先の振り分け（.claude/settings.json と .claude/hooks/*.sh で異なる）:
#   docs/knowledge/hook-distribution-policy.md
# zip作成は`zip`コマンド優先、無ければWindows標準のpowershell.exeに
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
  ".gitattributes"
  "CLAUDE.md"
  "docs/system.md"
  ".agents/skills/code-comment-rules/SKILL.md"
  ".agents/skills/discussion-rules/SKILL.md"
  ".agents/skills/documentation-rules/SKILL.md"
  ".agents/skills/documentation-rules/references/document-types.md"
  ".agents/skills/writing-style-rules/SKILL.md"
  ".dev/handoff-template.md"
  ".dev/index.md"
  ".claude/hooks/check-frontmatter.sh"
  ".claude/hooks/check-handoff-length.sh"
  ".claude/hooks/check-index-sync.sh"
  ".claude/hooks/check-adr-orphan.sh"
  ".claude/hooks/sweep-doc-checks.sh"
  ".claude/hooks/README.md"
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
