---
type: knowledge
tags: [structure, decision, hook]
updated: 2026-08-31
---
# hookのフレームワーク配布方針

`.claude/settings.json`・`.claude/hooks/*.sh`は現在rootにのみ存在し、テンプレート配布（`.dev/template-src/`・`project-template/`）には含まれていない。配布するかどうかの検討で、以下を決定した。

- `jq`依存は許容する。配布する場合、`jq`が無い環境ではhookを設定しない（エラーにしない）
- メッセージの日本語固定は許容する。このプロジェクトの第一ユーザーは作成者本人であるため
- セッション境界リマインダー（`session-boundary-reminder.sh`、Stop/PreCompact）はテンプレートへ配布せず、root専用の運用に留める。root側でさらに活用する方向性はあるが、配布は目指さない

未決: `jq`有無に応じたhookの条件付きセットアップの具体的な実装、frontmatter必須・handoff行数目安・index.md整合（PostToolUseの3種）を実際にテンプレートへ配布するかどうかとその方法は、[.dev/scratch/hook-template-distribution-setup.md](../../.dev/scratch/hook-template-distribution-setup.md)で検討中。
