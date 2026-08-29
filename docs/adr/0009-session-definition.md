---
type: adr
status: accepted
updated: 2026-08-24
---
# ADR-0009: 「セッション」を定義する

## Context
「セッション」という語はHandoff・todo.mdの運用（ADR-0003, 0005, 0007）やdocumentation-rules・AGENTS.mdで多用されているが、語自体を定義したものが無い。ADR-0003はHandoff更新の境界条件を列挙しているだけで、語の定義ではない。以前documentation-rules側でこの語を定義していたが、ADRの実質的な意味をskillが補う形になっていたため撤去した結果、定義そのものが失われていた。

## Decision
「セッション」とは、ADR-0003の境界条件のうち時間的な区切りである(1)中断・終了直前、(2)コンテキスト圧縮の前後、で区切られる区間を指す。(3)（大きな決定の発生）はセッションの区切りを意味しない。

## Consequences
「セッションをまたぐ追跡価値があるか」（Issue/todoの分類基準、ADR-0005・0006）が判定可能になる。

## Alternatives Considered
skill（documentation-rules）内で定義する案は、ADRの意味をskillが実質的に補う形になり、ADR-0007で是正した問題を再発させるため却下した。
