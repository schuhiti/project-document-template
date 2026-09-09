---
type: knowledge
tags: [structure, template-distribution]
updated: 2026-09-09
---
# root/templateのビルド

root（このプロジェクト自身）と`project-template/`（配布用テンプレート）は多くのファイルが同一内容だが、一部は本質的に内容が異なる。`.dev/build-template.sh`が`project-template/`を毎回ゼロから組み立てる（経緯: [2026-08-30-template-build-from-source.md](../adr/2026-08-30-template-build-from-source.md)）。

- テンプレート固有の一次情報は`.dev/template-src/`にソースとして置く（`project-template/`と同じディレクトリ構造）
- `project-template/`はビルド成果物として扱い、実行のたびに丸ごと削除して作り直す（差分更新はしない）
- rootと内容が同一であるべきファイルは許可リスト方式でスクリプトに列挙する
- root自身の`docs/adr/index.md`は自動生成しない。`knowledge`の経緯記録を`docs/adr/`へ移した時に手動で1行追加する（`docs/knowledge/adr-retirement.md`参照）
- root側`docs/index.md`はビルド対象外。手動で個別に維持する

## root専用（templateに存在しない）

`docs/premise.md`、`handoff.md`、`.dev/scratch/*`、`docs/knowledge/*`、`docs/adr/`（凍結された自プロジェクトの決定履歴）、`AGENTS.md`（内容がテンプレート版と異なるため。以下参照）、`README.md`（このリポジトリ自身を説明する文書であり、配布先プロジェクトは自分自身のREADMEを別途持つべきため同梱しない）

## テンプレート固有の一次情報（`.dev/template-src/`に保持）

`SETUP.md`、`docs/index.md`（テンプレート版の内容）、`AGENTS.md`（テンプレート版）、`.claude/settings.json`

rootとテンプレートはどちらも、指示を「プロジェクト固有の指示を書く薄い`AGENTS.md`」と「ドキュメント運用ルール本体（`docs/system.md`）」に分けている（経緯: [2026-08-30-template-build-from-source.md](../adr/2026-08-30-template-build-from-source.md)）。`docs/system.md`は共有ファイルなので写す作業は要らない。`AGENTS.md`だけが個別管理で、テンプレート版はプロジェクト固有の指示を書くコメント欄を持ち、root版はチャットへの適用を1行持つ。

`.claude/settings.json`は、root版がStop/PreCompactのhookも含むため内容が異なる。参照先のhookスクリプト自体（`.claude/hooks/*.sh`）は内容が同一なので共有ファイルとして列挙する。どのhookを配布するかは[hook-distribution-policy.md](hook-distribution-policy.md)。

共有ファイル（許可リスト方式でroot/templateへ同一内容のままコピーされるファイル。`documentation-rules/SKILL.md`等）は、root自身の個別の選択（連番・Status付きADRの凍結、root/templateの分割構造等）を前提にした記述を書かない。配布先プロジェクトはその構造を持たないため、その前提での助言は意味を成さない。前提が変わりうる場合は条件を明示するか、条件によらない書き方にする。例: 置き場所をファイル名で名指しせず、「ドキュメント参照表」のように役割で参照する。
