---
type: knowledge
tags: [structure, decision]
updated: 2026-08-31
---
# ツール非依存は目指す方向であり、厳密な制約ではない

`docs/premise.md`の「ツールは特定のAIエージェントに固定しない」は、複数ツールを吸収する互換レイヤー・アダプタの開発を主目的とすることを意味しない。Claude Code・Codexそれぞれのネイティブな機能（`.claude/skills`のシンボリックリンク、Claude Codeのhook等）を使うことを許容し、両者を統一的に吸収する抽象化は追求しない。

この方向性は[ADR-0010](../adr/0010-claude-code-codex-compatibility.md)（ネイティブパスをそのまま正本にする）と整合する。

背景: hookをフレームワークの一部として配布すべきか検討する中で、hookがClaude Code固有の機構であることが「特定のツールに固定しない」という前提と衝突するように見えたため、前提の意味を明確化した。

範囲: どの程度の互換性スクリプト・自動化を用意するかは別途検討する（[.dev/scratch/hook-template-distribution-setup.md](../../.dev/scratch/hook-template-distribution-setup.md)参照、未着手）。
