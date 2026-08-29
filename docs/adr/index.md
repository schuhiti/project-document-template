---
type: index
updated: 2026-08-29
---
# ADR一覧

| ファイル | 内容 |
|---|---|
| [TEMPLATE.md](TEMPLATE.md) | ADRのひな形 |

| # | タイトル | Status |
|---|---|---|
| [0001](0001-agents-md-as-canonical-hub.md) | AGENTS.md をプロジェクト前提・ルール参照の正本とする | accepted |
| [0002](0002-okf-frontmatter.md) | 文書のfrontmatterはOpen Knowledge Format (OKF) の最小構成を採用する | accepted |
| [0003](0003-handoff-update-timing.md) | Handoffの作成・更新はセッション/コンテキストの境界でのみ行う | accepted |
| [0004](0004-scratch-recording-criteria.md) | `.dev/scratch/`の記録基準と運用を確定する | accepted |
| [0005](0005-todo-md.md) | セッション内の実行項目を保持する`.dev/todo.md`を新設する | accepted |
| [0006](0006-issue-granularity.md) | GitHub Issueの粒度を「doneの定義が明確な単位」とする | accepted |
| [0007](0007-todo-triage-boundary.md) | todo.mdの棚卸し境界をADR-0003の(1)(2)に限定する | accepted |
| [0008](0008-adr-mixing-disclosure.md) | テンプレート内のフレームワーク由来ADRと、配布先プロジェクトのADRの混在は、README.mdで開示する | accepted |
| [0009](0009-session-definition.md) | 「セッション」を定義する | accepted |
| [0010](0010-claude-code-codex-compatibility.md) | Claude CodeとCodexへの具体的な適合方法を確定する | accepted |
| [0011](0011-agents-directory-boundary.md) | `.agents/`配下全体を外部規約の管轄として本Skillの規約から除外する | accepted |
| [0012](0012-adr-0010-triggers.md) | ADR-0010の未確認事項に再検討トリガーを補う | accepted |
| [0013](0013-knowledge-type.md) | 判断も手順も伴わない確定した内容を書く`knowledge`種別を新設し、`design`を統合する | accepted |

ADRの新規作成は終了しているため、このファイルは静的（`docs/knowledge/adr-retirement.md`参照）。稀な例外でADRを追加する場合は、この表に手動で1行追加する。
