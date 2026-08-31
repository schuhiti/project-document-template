# project-document-template

個人開発者がAI coding agent（Claude Code、Codex等）と共に開発する小規模プロジェクト向けの、文書体系テンプレート。

議論の蒸し返しを避け、判断の根拠を保存し、AIエージェントが必要な文脈を必要なタイミングで参照できるようにすることを目的とする。premise（前提）・knowledge（確定した知見）・scratch（検討メモ）・handoff（引き継ぎ）等の文書種別と、それぞれの運用ルールをセットで提供する。

## 使い方

`project-template/`・`project-template.zip` はビルド成果物のためリポジトリに含まれない。次の手順で生成する。

1. このリポジトリをクローンする
2. `.dev/build-template.sh` を実行し、`project-template/`（と`project-template.zip`）を生成する
3. 生成された中身を新しいプロジェクトにコピーする。`.gitattributes`（`*.sh`の改行コードをLFに固定するだけで、通常は問題にならない）はコピー先に既にあれば上書きせず、`*.sh`に関する記述をgrepで確認した上で無ければ追記する。競合する・判断に迷う場合はコピーを中止し人間に確認する
4. `SETUP.md` の手順に従う

## ツール対応方針

特定のAIエージェントに固定しないことを目指すが、それ自体を主目的とはしない。Claude Code・Codexそれぞれのネイティブな機能（skillsの配置、hook等）を使うことを許容し、両者を統一的に吸収する互換レイヤーの開発は目指さない。詳細は [docs/knowledge/tool-neutrality-scope.md](docs/knowledge/tool-neutrality-scope.md) を参照。

## hookについて

同梱のhook（frontmatter必須・handoff行数目安・index.md整合の機械チェック、Claude Code向け）は`jq`に依存する。`jq`が無い環境では`.claude/settings.json`・`.claude/hooks/`を使わず、hookは有効にならない。この場合ルール適用の確実性は落ちるが、文書体系自体は`jq`が無くても利用できる。

## このリポジトリ自体について

このリポジトリ自身も、このテンプレートが提案する文書体系に従って運用している。`AGENTS.md` がエージェント向け指示の起点で、`docs/system.md` 相当の内容は `AGENTS.md` に統合されている（配布用テンプレート側では `AGENTS.md` と `docs/system.md` に分割済み。理由は [docs/knowledge/root-template-sync.md](docs/knowledge/root-template-sync.md) を参照）。

## ライセンス

[MIT](LICENSE)
