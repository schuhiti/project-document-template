---
type: knowledge
tags: [structure, decision, hook]
updated: 2026-09-02
---
# hookのフレームワーク配布方針

frontmatter必須・handoff行数目安・index.md整合（PostToolUseの3種）は、`.claude/hooks/*.sh`をSHARED_FILES、`.claude/settings.json`を`.dev/template-src/`として`.dev/build-template.sh`に組み込み、テンプレートへ配布した。settings.jsonはroot版と内容が異なる（root版はStop/PreCompactも含む）ため、テンプレート版は`.dev/template-src/.claude/settings.json`で個別に管理する。

- `jq`依存は許容する。`jq`が無い環境向けの条件分岐はスクリプト化せず、`SETUP.md`に「`jq --version`が通らなければ`.claude/settings.json`・`.claude/hooks/`を削除する」という手順を追記するだけに留めた（配布フロー自体が手作業前提のため、専用のインストールスクリプトは今の規模に見合わない）
- メッセージの日本語固定は許容する。このプロジェクトの第一ユーザーは作成者本人であるため
- セッション境界リマインダー（`session-boundary-reminder.sh`、PreCompact。Stopでの運用は廃止した経緯は`docs/knowledge/stop-hook-boundary-mismatch.md`参照）はテンプレートへ配布せず、root専用の運用に留める。root側でさらに活用する方向性はあるが、配布は目指さない
- Codex（`apply_patch`をmatcherにした同種hook）への互換性実装は見送った。matcher・パス抽出ロジックとも別実装が必要な上、Codex側hookは実行前に人間の明示的な信頼登録が要るため配っても自動では有効にならず、現時点で具体的な需要も無い。トリガー: Codexユーザーから具体的な要望が出た時
