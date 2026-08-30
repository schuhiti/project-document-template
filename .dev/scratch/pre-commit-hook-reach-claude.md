---
type: scratch
status: 検討中
updated: 2026-08-31
---
# 検討: pre-commit-doc-reminder.shをClaudeに確実に届ける方法

[pre-commit-doc-reminder.sh](../../.claude/hooks/pre-commit-doc-reminder.sh)（PreToolUse、`git commit`検知）は現状exit 0のstderr出力のみで、デバッグログにしか残らずClaudeには届いていない。`Stop`/`PreCompact`と違い、PreToolUseは`hookSpecificOutput.additionalContext`に非対応で、Claudeに確実に見せる手段はブロック（`permissionDecision: deny`、旧exit 2）以外に無い。単純にブロックすると、ブロック条件（ステージ済み`.md`の有無）がリトライで変わらないため無限ループする。

検討した選択肢:
- **A. 現状維持**: 何もしない。今回の目的（Claudeに確認させる）は達成できないままだが、実装コストはゼロ
- **B. セッション単位マーカー**: hook入力の`session_id`をキーに、セッション内で一度ブロックしたら以降は通す。実装は数行増える程度だが、「セッション内で一度確認すればそれ以降は無条件通過」という粗さがある
- **C. 差分ハッシュ単位マーカー**: `git diff --cached -- '*.md'`のハッシュをキーに、前回ブロック時と同じ内容なら通す。意図（この差分を確認したか）に近いが、ハッシュ計算・マーカーファイルの読み書きが増え、他のhookより複雑になる

どの案も「ブロックして一度は目の前に出す」ことしか保証できず、「実際に読んで判断したか」までは検証できない（Stopの`additionalContext`修正と違い、PreToolUseには確実な非ブロッキング配信手段が無いための構造的な上限）。

トリガー: 方針が決まった時。またはB/C案を採用する場合、実装後に無限ループが実際に起きないか動作確認する。
