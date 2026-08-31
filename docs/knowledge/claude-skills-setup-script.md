---
type: knowledge
tags: [structure, decision]
updated: 2026-08-31
---
# `.claude/skills`のセットアップはスクリプト化し、失敗はハードエラーにした

`.claude/skills`のセットアップ手順（`ln -s`→検証→Windowsではジャンクション試行→失敗時の扱い）を、AGENTS.md/docs/system.mdのプローズから[.claude/setup-skills.sh](../../.claude/setup-skills.sh)へ切り出した。

理由: 従来は失敗時に「管理者権限・開発者モードが無い旨を記録した上で再確認する」という黙認で、Skillが読めないままセッションを続行できてしまっていた。documentation-rules・discussion-rulesが読めない状態は本Skill体系の前提が崩れているに等しいため、非ゼロ終了＝ハードエラーとして人間に報告させる方針に変えた。判定をプローズの解釈でなくスクリプトの終了コードで表現する方が確実という理由もある。`.agents/skills/`配下のSkillにはできない（`.claude/skills`が壊れている状況を検知するSkill自体がその`.claude/skills`経由でしか読み込めず循環するため）。

セットアップは実質べき等で、有効なリンクが既にあれば即終了する。「セッションごとに必ず行う」のは既存の状態を確認する1ステップであって、フルの再作成ではない。

あわせて、Claude Code固定を選ぶプロジェクト向けに、`.agents/`を`.claude/`へリネームして一本化する選択肢を`SETUP.md`に追記した。この場合`.claude/setup-skills.sh`自体が不要になる代わりに、Codexは`.agents/skills/`を直接読むため使えなくなる。
