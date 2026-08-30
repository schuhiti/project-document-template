---
type: scratch
status: 検討中
updated: 2026-08-31
---
# 検討: Codexのセッション境界hookは保留

Claude Codeでは`Stop`/`PreCompact`が「セッション境界」の粒度と一致するため、`.claude/hooks/session-boundary-reminder.sh`をそのまま割り当てられた。Codexには同じ粒度のイベントが無い: `Stop`はターンごとに発火し、`SessionEnd`は「会話削除/アーカイブ/30分以上放置」で発火するため、意図した区切り（作業の中断・終了直前、コンテキスト圧縮前後）と一致しない。加えて[openai/codex#17532](https://github.com/openai/codex/issues/17532)で、repo-local `.codex/config.toml`経由の`SessionStart`/`Stop`フックが対話セッションで発火しないバグが未解決のまま報告されている。

frontmatter必須・handoff行数目安・index.md整合の3点（[check-frontmatter.sh](../../.claude/hooks/check-frontmatter.sh)等）はCodexでも`apply_patch`ツールをmatcherにした同種のhookで機械化できる見込みだが、対象外（薄いスクリプトで済む範囲に絞る方針のため今回は未着手）。

トリガー: openai/codex#17532が解決した時、またはCodexにセッション境界相当のイベントが追加された時。
