# セットアップ

このテンプレートで新しいプロジェクトを始める手順。

## 1. このテンプレートが前提にしていること

以下は質問ではなく、このテンプレートの既定方針。変更する場合は、それぞれの指示に従う。

- **`AGENTS.md`はこのプロジェクト固有の指示を書く場所**（ビルド・テスト手順、コーディング規約等）。ドキュメント運用のルール本体は`docs/system.md`に分離してあり、`AGENTS.md`はそれを参照するだけの薄いファイルとして同梱されている
- **Issue/PR管理はGitHubを使う**（GitHub Issues=ToDo、GitHub Discussions=検討中の議論）。他のツールを使う場合、`docs/system.md`と`.agents/skills/documentation-rules/SKILL.md`の該当行を書き換える
- **単一リポジトリ構成**。モノレポは現状未対応（トリガー: 実際にモノレポ構成が必要になった時に設計する）
- **ADRは最初から作らない**。決定は反映される場所（`AGENTS.md`・`docs/premise.md`・documentation-rules等）に理由を直接書き添え、分量が増えるものは`docs/knowledge/`へ独立したファイルとして記録する。そのファイルが`documentation-rules`の「決定・経緯の記録」の4条件を満たした時点で、`docs/adr/`を作って移し、不変の記録として扱ってよい（理由: このテンプレートを作ったプロジェクト自身が13本のADRを作った後にやめた。ADRを規範の出所として引用したため、生きた文書を直せば済む修正がADRの追加になり、補正の連鎖が起きた。重要な決定を待つ器を先に用意すると、この誤用に戻りやすい）

## 2. AIツール別のセットアップ

**Codex**: `.agents/skills/`・`AGENTS.md`とも直接読むため、追加の作業は不要。

**Claude Code**: `CLAUDE.md`（`@AGENTS.md`のみを書いたファイル）は同梱済みで、追加の作業は不要。Skillだけは例外で、`.claude/skills`が必要（`docs/system.md`の「セッション開始・再開時に必ず行うこと」1が`.claude/setup-skills.sh`を実行する指示になっている。初回セッションでAI自身が実行する）。`.claude/settings.json`・`.claude/hooks/`（frontmatter必須・handoff行数目安・index.md整合・決定の記録の孤立をPostToolUseで機械チェックするhookと、Write/Edit以外の経路で編集した分をターン終了時に拾うhook）も同梱済みだが、`jq`コマンドに依存する。`jq --version`が通らない環境では、この2つを削除する（無いまま残すとhookがエラーになる）。

## 3. AIエージェントを特定ツールに固定するか決める

ツールを固定するかどうかと、どのファイルに指示を書くかは別の決定である。

- **AGENTS.mdに指示を書く場合**（既定。ツールを固定してもよくある選択。移植性やエコシステムの慣習を理由に選べる）: 何もしなくてよい。ツールを固定するかどうかの事実は、4の質問の回答としてpremise.mdに書く
- **特定ツールのファイル（例: CLAUDE.md）に指示を書く場合**: `AGENTS.md`冒頭を新しい構成に書き換える。premise.mdにもその判断を記録する
- **`.agents/`を`.claude/`へリネームして一本化する**（Claude Code固定を選ぶ場合のみ）: `.claude/setup-skills.sh`によるシンボリックリンク/ジャンクション作成が不要になる。代わりにCodexは`.agents/skills/`を直接読むため使えなくなる。選ぶ場合は`.claude/setup-skills.sh`を削除し、`.agents/skills/documentation-rules/SKILL.md`内の`.agents/`配下という記述を書き換え、premise.mdにその判断を記録する

## 4. 質問に答える

- プロジェクト名は？
- 一言で言うと何を作るか？
- 扱うドメイン・主要な概念は何か？（例: ECサイトなら「注文」「在庫」「決済」）
- 明確に扱わないことは何か？その理由は？（今は思いつかなければ空でよい。後で気づいた時に追記する）
- 公開予定はあるか？（OSS公開／製品として公開／非公開のまま）

## 5. docs/premise.md を作る

回答を次の形式で `docs/premise.md` として保存する。

```markdown
---
type: premise
updated: <今日の日付>
---
# プロジェクト前提

- <質問への回答を確定した前提として箇条書きにする>
```

加えて、次のデフォルト方針も含める（変更したい場合だけ書き換える。書き換えるなら、理由と却下した代替案を`docs/knowledge/`に残すことを検討する）。

- 個人開発者がAI coding agentと共に検討・作業する体制を、ごく小規模なチーム開発とみなす
- 公開時のセキュリティ等、必要な事項は妥協しない。それ以外は機能に必要な範囲・規模で適切に検討する
- エンタープライズにおける運用、ビジネス上要請される細かな記録、大規模開発の方法論は無闇に導入しない
- 文書体系の目的は次の3点: (1) 議論の蒸し返しを避ける (2) 判断の根拠を保存する (3) AIが必要な文脈を必要なタイミングで参照できるようにする

## 6. 確認する

- `AGENTS.md`は`docs/system.md`を参照するよう指示しており、`docs/system.md`がセッション開始時に `docs/premise.md` → `.dev/handoff.md`（存在すれば）の順で読む手順を持つ
- `.dev/handoff.md` はまだ存在しない。最初の作業セッションの終わりに `.dev/handoff-template.md` を元に作る
- `docs/knowledge/`・`.dev/scratch/`・`.dev/todo.md` は、必要になった時点で作る（最初から空ディレクトリ/ファイルを用意する必要はない）。`docs/knowledge/`は判断も手順も伴わない確定した内容の置き場所、`.dev/scratch/`はAIも参照する検討メモの置き場所、`.dev/todo.md`はセッション内で完結する実行項目の置き場所。**新しいディレクトリを作る際は、必ず`index.md`も同時に作る**（`.agents/`・`.claude/`配下を除く。`.agents/skills/documentation-rules/SKILL.md`参照）
- 同梱の`.agents/skills/*/SKILL.md`等に入っている`updated`日付はこのテンプレートの配布時点のもの。使い始めた時点で一律更新する必要はなく、実際に編集した時に更新すればよい

## 7. 後片付け

`docs/premise.md` ができたら、このファイル（SETUP.md）は役目を終えたので削除してよい。
