#!/bin/bash
# .claude/skills のセットアップ。AGENTS.md/docs/system.mdの
# 「セッション開始・再開時に必ず行うこと」から呼ばれる。
#
# 既に有効なリンクがあれば即終了(べき等)。無ければ ln -s を試み、
# 真のシンボリックリンクにならなかった場合(Windowsで管理者権限・
# 開発者モードが無いと、ln -s はエラーを出さず独立コピーを作ってしまう。
# CLAUDE.mdをAGENTS.mdへのシンボリックリンクにしなかったのも同じ制約)、
# Windowsではジャンクション作成を試す。ジャンクションは相対パス非対応
# のため絶対パス(cygpath -w で取得)が必須。
#
# いずれも失敗したら非ゼロで終了する。Skillを読めない状態のまま黙って
# 作業を続けるのは本Skill体系の前提が壊れているに等しいため、ここで
# 止めて人間に報告する(AGENTS.md/docs/system.md側の指示)。
#
# 真のリンク・ジャンクションいずれでコミットしても、真のリンクは
# core.symlinks=false の環境で正しく取り出せず、ジャンクションは
# 絶対パス依存のため別の場所へチェックアウトすると壊れる。そのため
# Windowsではコミットせず、.git/info/exclude(共有の.gitignoreではなく
# ローカル限定の除外。Linux/macOSでのコミットを妨げないため)に
# 除外を追記した上で、セッションごとにその場で作り直す(暫定運用)。
#
# 見直し条件: Claude CodeがAGENTS.mdへ直接対応する等、ツールの対応
# 状況が変わった場合、この仕組み全体を見直す。
set -u

mkdir -p .claude

if [ -L .claude/skills ] && [ -e .claude/skills/documentation-rules/SKILL.md ]; then
  exit 0
fi

is_windows=0
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*) is_windows=1 ;;
esac

rm -rf .claude/skills
ln -s ../.agents/skills .claude/skills

linked=0
[ -L .claude/skills ] && linked=1

if [ "$linked" -ne 1 ] && [ "$is_windows" -eq 1 ]; then
  rm -rf .claude/skills
  abs="$(cygpath -w "$(pwd)")"
  if powershell.exe -NoProfile -Command "New-Item -ItemType Junction -Path '${abs}\.claude\skills' -Target '${abs}\.agents\skills'" >/dev/null 2>&1; then
    linked=1
  fi
fi

[ "$linked" -eq 1 ] && [ ! -e .claude/skills/documentation-rules/SKILL.md ] && linked=0

if [ "$linked" -ne 1 ]; then
  echo "エラー: .claude/skillsを作成できなかった(シンボリックリンク・ジャンクションともに失敗、または作成できても中身が正しく参照できない)。管理者権限・開発者モード・ジャンクション作成権限を確認するか、作成できる環境で再実行すること。自己判断で回避せず人間に報告して指示を仰ぐこと。" >&2
  exit 1
fi

if [ "$is_windows" -eq 1 ]; then
  grep -qxF ".claude/skills" .git/info/exclude 2>/dev/null || echo ".claude/skills" >> .git/info/exclude
fi

exit 0
