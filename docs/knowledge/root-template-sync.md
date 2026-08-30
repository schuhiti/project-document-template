---
type: knowledge
tags: [structure, template-distribution]
updated: 2026-08-30
---
# root/templateのビルド

root（このプロジェクト自身）と`project-template/`（配布用テンプレート）は多くのファイルが同一内容だが、一部は本質的に内容が異なる。一括で`cp`すると、異なるべきファイルを誤って上書きする（実際に2回発生した）。

さらに、テンプレート固有の一次情報（`SETUP.md`、テンプレート版`docs/index.md`）はroot側に対応する元データが存在せず、他の共有ファイルとは性質が異なる。これらを`project-template/`ディレクトリに直接置いたまま同期スクリプトを繰り返し実行すると、「このファイルは同期対象か手動維持か」を都度判断する必要が生じ、事故の元になる。

対処として、`.dev/build-template.sh`を「同期」ではなく「毎回ゼロから組み立てるビルド」に設計し直した。

- テンプレート固有の一次情報は`.dev/template-src/`にソースとして置く（`project-template/`と同じディレクトリ構造）
- `project-template/`はビルド成果物として扱い、実行のたびに丸ごと削除して作り直す（差分更新はしない）。これにより「同期対象か手動維持か」の判断自体が不要になる
- rootと内容が同一であるべきファイルは許可リスト方式でスクリプトに列挙する
- root自身の`docs/adr/index.md`はADRの新規作成をやめたため静的（`docs/knowledge/adr-retirement.md`参照）。自動生成はせず、稀な例外でADRを追加する場合のみ手動で更新する
- root側`docs/index.md`はビルド対象外。手動で個別に維持する

## root専用（templateに存在しない）

`docs/premise.md`、`handoff.md`、`.dev/scratch/*`、`docs/knowledge/*`、`docs/adr/`（凍結された自プロジェクトの決定履歴）、`AGENTS.md`（内容がテンプレート版と異なるため。以下参照）

## テンプレート固有の一次情報（`.dev/template-src/`に保持）

`SETUP.md`、`docs/index.md`（テンプレート版の内容）、`AGENTS.md`（テンプレート版）、`docs/system.md`

テンプレート版`AGENTS.md`・`docs/system.md`は、root版`AGENTS.md`を「プロジェクト固有の指示を書く薄いAGENTS.md」と「ドキュメント運用ルール本体（docs/system.md）」に分割したもの。root版`AGENTS.md`をそのまま配布すると、配布先プロジェクト自身の固有の指示（AGENTS.mdエコシステムで一般的に書かれる内容）を書く場所が無くなるため分離した。自動生成はせず、root版`AGENTS.md`を大きく変更した際に手動で反映する。

この分割により、共有ファイル（許可リスト方式でroot/templateへ同一内容のままコピーされるファイル。`documentation-rules/SKILL.md`等）の中で「ドキュメントの参照先」の実体を`AGENTS.md`と名指しする記述は、template側では誤りになる（実体は`docs/system.md`にあるため）。共有ファイルでは、置き場所をファイル名で名指しせず「ドキュメント参照表」のように役割で参照する。
