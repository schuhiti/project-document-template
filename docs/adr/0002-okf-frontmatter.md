---
type: adr
status: accepted
updated: 2026-08-24
---
# ADR-0002: 文書のfrontmatterはOpen Knowledge Format (OKF) の最小構成を採用する

## Context
文書のメタデータ（種別・更新日等）を機械的に扱えるようにしたい一方、独自に複雑なスキーマを設計する手間は避けたい。Google CloudのOpen Knowledge Format (OKF) が、typeフィールドのみを必須とし、他は作成者に委ねるという最小限のfrontmatter規約と、ディレクトリごとのindex.mdによる段階的なナビゲーションを提案している。ADRの索引は当初、数が増えてから作る想定だったが、index.mdの実際のコストが低いことが分かったため、この機会に見直す。

## Decision
`docs/premise.md`・`docs/adr/`・`docs/design/`・`.dev/handoff.md`・`.dev/scratch/`など自前の文書種別には、OKFに準拠した最小限のYAML frontmatterを付与する。必須は`type`のみとし、`status`・`updated`・`tags`は種別に応じて任意で使う。ディレクトリごとの`index.md`も同様に採用する。`AGENTS.md`と`skills/*/SKILL.md`はそれぞれ別の外部仕様（AGENTS.md規約、SKILL.md規約）に従うため対象外とする。

## Consequences
grepや将来的な検索が容易になり、ディレクトリ単位のindex.mdで見通しも良くなる。一方、既に作成済みの文書へ遡って追加する手間が生じる。

## Alternatives Considered
独自の詳細なフロントマタースキーマを設計する案は、複雑さに見合う利益が今の規模では無いため却下した。frontmatterを一切使わない案は、将来的な検索性を損なうため却下した。
