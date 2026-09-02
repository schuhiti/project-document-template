---
type: template
updated: 2026-08-24
---
# ADRテンプレート

新しいADRを作る際は、`docs/adr/NNNN-slug.md`として、下の枠内（コピー範囲）をそのままコピーする。枠外の説明はコピーしない。

コピー範囲:

```
---
type: adr
status: proposed
updated: YYYY-MM-DD
---
# ADR-NNNN: <タイトルを1行で>

## Context
<!-- なぜこの決定が必要だったか。背景・制約。1段落以内 -->

## Decision
<!-- 何を決定したか。1段落以内 -->

## Consequences
<!-- この決定によるトレードオフ・影響。1段落以内 -->

## Alternatives Considered
<!-- 検討した代替案とその却下理由。該当する場合のみ。1段落以内 -->
```

コピー範囲ここまで。

補足: statusはfrontmatterのみで管理する。supersede時はここを `status: superseded`, `superseded_by: ADR-NNNN` に更新する。本文（Context以下）は不変。
