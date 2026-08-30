# project-document-template

個人開発者がAI coding agent（Claude Code、Codex等）と共に開発する小規模プロジェクト向けの、文書体系テンプレート。

議論の蒸し返しを避け、判断の根拠を保存し、AIエージェントが必要な文脈を必要なタイミングで参照できるようにすることを目的とする。premise（前提）・knowledge（確定した知見）・scratch（検討メモ）・handoff（引き継ぎ）等の文書種別と、それぞれの運用ルールをセットで提供する。

## 使い方

`project-template/`・`project-template.zip` はビルド成果物のためリポジトリに含まれない。次の手順で生成する。

1. このリポジトリをクローンする
2. `.dev/build-template.sh` を実行し、`project-template/`（と`project-template.zip`）を生成する
3. 生成された中身を新しいプロジェクトにコピーし、`SETUP.md` の手順に従う

## このリポジトリ自体について

このリポジトリ自身も、このテンプレートが提案する文書体系に従って運用している。`AGENTS.md` がエージェント向け指示の起点で、`docs/system.md` 相当の内容は `AGENTS.md` に統合されている（配布用テンプレート側では `AGENTS.md` と `docs/system.md` に分割済み。理由は [docs/knowledge/root-template-sync.md](docs/knowledge/root-template-sync.md) を参照）。

## ライセンス

[MIT](LICENSE)
