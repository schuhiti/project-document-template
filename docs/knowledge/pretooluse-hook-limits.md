---
type: knowledge
tags: [structure, decision, hook]
updated: 2026-08-31
---
# PreToolUseフックでのcommit前チェックは廃止した

`git commit`実行前に文書規約対象の`.md`があればリマインドするPreToolUseフックを実装したが、廃止した。

理由: PreToolUseはStop/PreCompactと違い`hookSpecificOutput.additionalContext`に非対応で、Claudeへ確実に届ける手段はブロック（`permissionDecision: deny`）しか無い。ブロック条件（ステージ済み`.md`の有無）はリトライしても変わらないため、単純にブロックすると同じコマンドを再実行するたびに無限ループする。ループを避けるにはセッション単位・差分ハッシュ単位のマーカーファイルによる状態管理が必要になり、実装の複雑さがこのプロジェクトの規模に見合わない。

以後の運用: commit前の文体・構成原則（writing-style-rulesの「構成」）の確認は、hookではなく、コミット前に`git diff --staged`を読む習慣で対応する。

却下した代替案: セッション単位マーカー・差分ハッシュ単位マーカーによるブロック型実装。どちらも「ブロックして一度は目の前に出す」ことしか保証できず、実装コストに見合う効果が無いと判断した。

対比: Stop/PreCompactは`additionalContext`に対応しているため、同種のリマインダー（セッション境界でのhandoff/todo確認）はそちらのhookで機能している。
