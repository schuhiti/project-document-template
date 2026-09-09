---
type: knowledge
tags: [structure, decision, hook]
updated: 2026-09-09
---
# hookのフレームワーク配布方針

PostToolUseの4種（frontmatter必須・handoff行数目安・index.md整合・決定の記録の孤立）はテンプレートへ配布する。ビルド上の構成は[root-template-sync.md](root-template-sync.md)が持つ。

- `jq`依存は許容する。`jq`が無い環境向けの条件分岐はスクリプト化せず、`SETUP.md`に「`jq --version`が通らなければ`.claude/settings.json`・`.claude/hooks/`を削除する」という手順を追記するだけに留めた（配布フロー自体が手作業前提のため、専用のインストールスクリプトは今の規模に見合わない）
- メッセージの日本語固定は許容する。このプロジェクトの第一ユーザーは作成者本人であるため
- セッション境界リマインダー（`session-boundary-reminder.sh`、PreCompact。Stopでの運用は廃止した経緯は`docs/knowledge/stop-hook-boundary-mismatch.md`参照）はテンプレートへ配布せず、root専用の運用に留める。root側でさらに活用する方向性はあるが、配布は目指さない
- Codex向けhookの互換実装は保留（`.dev/scratch/codex-hook-compat.md`）
