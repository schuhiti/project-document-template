---
type: scratch
status: 検討中
updated: 2026-09-09
---
# 検討: Codex向けhookの互換実装は保留

Claude Code用に`.claude/hooks/`へ置いた5種のうち、Codexへ移せるかどうかは種類によって事情が違う。どちらも保留で、トリガーが別なので分けて持つ。

## セッション境界リマインダー

Claude Codeでは`Stop`/`PreCompact`が「セッション境界」の粒度と一致するため、`session-boundary-reminder.sh`をそのまま割り当てられた。Codexには同じ粒度のイベントが無い。`Stop`はターンごとに発火し、`SessionEnd`は「会話削除/アーカイブ/30分以上放置」で発火するため、意図した区切り（作業の中断・終了直前、コンテキスト圧縮前後）と一致しない。加えて[openai/codex#17532](https://github.com/openai/codex/issues/17532)で、repo-local `.codex/config.toml`経由の`SessionStart`/`Stop`フックが対話セッションで発火しないバグが未解決のまま報告されている。

トリガー: openai/codex#17532が解決した時、またはCodexにセッション境界相当のイベントが追加された時。

## PostToolUseの4種（frontmatter必須・handoff行数目安・index.md整合・決定の記録の孤立）

`apply_patch`をmatcherにした同種のhookで機械化できる見込みはある。見送った理由は、matcherとパス抽出ロジックがどちらも別実装になること、Codex側hookは実行前に人間の明示的な信頼登録が要るため配っても自動では有効にならないこと、現時点で具体的な需要が無いこと。

トリガー: Codexユーザーから具体的な要望が出た時。
