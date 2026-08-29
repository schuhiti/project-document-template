---
type: adr
status: accepted
updated: 2026-08-29
---
# ADR-0013: 判断も手順も伴わない確定した内容を書く`knowledge`種別を新設し、`design`を統合する

## Context
ADRは決定とその理由、Skillは手順、premiseはこのプロジェクト自身の前提を扱うが、判断も手順も伴わない確定した内容（ドメインの概念・用語、外部APIの癖、業界慣習、自システムの設計に関する個々の内容・事実等）を書く場所が無かった。一方`design`は、確定内容のみを上書き更新するという運用がこれとほぼ同一であり、独立した種別として区別する理由に乏しい。

## Decision
`docs/knowledge/`を新設する。フォルダ分けせずフラットに配置し、frontmatterは`type: knowledge`のみ必須とする。分類は単一の`class`ではなく複数値を持てる`tags`で行い、語彙は今は固定せず自由記述とする。書く契機はADR-0004と同じ再発見コストのテストを確定した内容に適用したものとし、内容が変われば上書き、不要になれば削除する。ファイル名はkebab-caseスラッグ、TEMPLATE.mdは用意しない。`index.md`を設置する。`design`は`knowledge`へ統合し廃止する。`premise`は統合しない。AGENTS.mdが唯一パスを直書きして毎セッション読む、単一・固定パスの文書であるため。scratchの遷移先は`premise/ADR/knowledge/Issue/.dev/todo.md`に更新する。

## Consequences
判断を伴わない確定した内容を`docs/knowledge/`で一元管理できる。documentation-rules・AGENTS.mdの参照表から`design`行が1つ減り`knowledge`行が1つ増える。design専用の置き場所を探すという行為自体が無くなり、design由来の内容も他のknowledgeと同列に扱われ、knowledge全体の索引・タグ検索で見つかる。design内容だけを特別に取り出す必要が実際に生じた場合は、その時点でtagの運用を検討する。

## Alternatives Considered
新種別の新設と`design`の統合を別ADRに分ける案は、後者の理由が前者の存在に直接依存しており分離すると片方だけでは意味を成さないため却下した。`class`（単一値）やフォルダでの分類案は、実例が無いまま区分を固定することになるため却下した。
