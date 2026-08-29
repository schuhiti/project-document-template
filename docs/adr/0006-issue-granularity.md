---
type: adr
status: accepted
updated: 2026-08-24
---
# ADR-0006: GitHub Issueの粒度を「doneの定義が明確な単位」とする

## Context
GitHub Issueの適切な大きさ（粒度）についての基準が定まっていなかった。ADR-0005（`.dev/todo.md`の新設）はこの基準の存在を前提にしていたが、基準自体を定めたADRが無く、根拠を辿れない状態だった。

## Decision
GitHub Issueの粒度は「doneの定義が明確な単位」とする。doneが定義できないものはscratchで論点を固めてからIssue化する。doneが定義できてもセッションをまたぐ追跡価値が無いものは`.dev/todo.md`に留める（ADR-0005）。

## Consequences
Issueの大きさに関する恣意的な判断が減り、scratch/todo/Issueの境界が一本の軸（doneの定義の有無、追跡範囲）で説明できるようになる。ADR-0005の前提を事後的に補強する形になる。

## Alternatives Considered
Issueのサイズ（工数や行数）で粒度を決める案は、doneが不明瞭なまま着手できてしまう問題を解決しないため却下した。
