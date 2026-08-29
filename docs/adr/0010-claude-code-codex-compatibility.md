---
type: adr
status: accepted
updated: 2026-08-24
---
# ADR-0010: Claude CodeとCodexへの具体的な適合方法を確定する

## Context
ADR-0001でAGENTS.mdを正本としたが、「AGENTS.md未対応のツールでは個別設定が必要」という点は未確認のまま残っていた。同様に、`skills/`ディレクトリがツールに自動読込されるかも未確認だった。調査の結果、Claude Codeは`AGENTS.md`を直接読まず`CLAUDE.md`を読む（2026年8月時点、対応予定なしと明言されている）。Skillの読込先もツールごとに固定パスが異なり、Claude Codeは`.claude/skills/`、Codexは`.agents/skills/`（作業ディレクトリからリポジトリルートまで遡って走査）。両ツールともこれらのディレクトリ内のシンボリックリンクを公式にサポートしている。

## Decision
- `CLAUDE.md`を新設し、内容を`@AGENTS.md`のみとする（Claude Code公式が推奨するインポート方式。シンボリックリンク方式はWindowsで管理者権限が必要なため避ける）
- Skillの実体を`.agents/skills/`に置く（Codexのネイティブパスと一致させ、Codex側は追加設定を不要にする）
- Claude Code用に `.claude/skills` を `.agents/skills` へのシンボリックリンクとして作成する。ただし作成はOS依存の操作であり、zipやテンプレートに事前に焼き込まず、セットアップ手順としてコマンドを明示し、利用者に実行してもらう

## Consequences
Claude Code・Codexの双方で、AGENTS.mdとSkillが実際に読み込まれるようになる。一方、シンボリックリンク作成はセットアップ手順に残る一手間になり、Windows環境では管理者権限またはDeveloper Modeが必要になる場合がある（未確認のまま残す）。

## Alternatives Considered
`CLAUDE.md`をシンボリックリンクで`AGENTS.md`に向ける案は、Windowsでの制約が大きいため、より安全なインポート方式を優先した。`skills/`を移動せず`.agents/skills/`・`.claude/skills`の両方をそこへのシンボリックリンクにする案は、シンボリックリンクが1つ増えるだけで利益が無いため、Codexのネイティブパスをそのまま正本にする方を選んだ。
