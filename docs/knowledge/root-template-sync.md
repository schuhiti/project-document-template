---
type: knowledge
tags: [structure, root-template-sync]
updated: 2026-08-29
---
# root/templateのビルド

root（このプロジェクト自身）と`project-template/`（配布用テンプレート）は多くのファイルが同一内容だが、一部は本質的に内容が異なる。一括で`cp`すると、異なるべきファイルを誤って上書きする（実際に2回発生した）。

さらに、テンプレート固有の一次情報（`SETUP.md`、テンプレート版`docs/index.md`）はroot側に対応する元データが存在せず、他の共有ファイルとは性質が異なる。これらを`project-template/`ディレクトリに直接置いたまま同期スクリプトを繰り返し実行すると、「このファイルは同期対象か手動維持か」を都度判断する必要が生じ、事故の元になる。

対処として、`.dev/build-template.sh`を「同期」ではなく「毎回ゼロから組み立てるビルド」に設計し直した。

- テンプレート固有の一次情報は`.dev/template-src/`にソースとして置く（`project-template/`と同じディレクトリ構造）
- `project-template/`はビルド成果物として扱い、実行のたびに丸ごと削除して作り直す（差分更新はしない）。これにより「同期対象か手動維持か」の判断自体が不要になる
- rootと内容が同一であるべきファイルは許可リスト方式でスクリプトに列挙する
- root自身の`docs/adr/index.md`はADR個票から機械生成する（rootの決定履歴は凍結して残す。templateには同梱しない）
- root側`docs/index.md`はビルド対象外。手動で個別に維持する

## root専用（templateに存在しない）

`docs/premise.md`、`handoff.md`、`.dev/scratch/*`、`docs/knowledge/*`

## テンプレート固有の一次情報（`.dev/template-src/`に保持）

`SETUP.md`、`docs/index.md`（テンプレート版の内容）
