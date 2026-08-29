---
type: handoff
updated: 2026-08-29
---
# Handoff — AIエージェント運用のための文書体系・整備

配置: `.dev/handoff.md`（完全上書き運用。テンプレート: `.dev/handoff-template.md`）

## 今どこまで進んだか (What)

文書体系は一通り完成している。

- 種別: premise/adr/knowledge/skill/scratch/handoff/template/index/todo（GitHub Issues/Discussionsと併用）
- ADRは新規作成を終了した（`docs/knowledge/adr-retirement.md`）。既存13本は`docs/adr/`に凍結し、内容は生きた文書へ書き写し済み。以後の決定は反映先に理由を直接書き添え、却下案は分量に応じて`scratch`（未確定）か`knowledge`（確定済み）へ
- `.dev/notes/`（人間専用メモ）は必要性が無かったため削除済み
- テンプレート配布は`.dev/template-src/`（一次情報: SETUP.md・テンプレート版docs/index.md）+ rootの共有ファイル → `.dev/build-template.sh` → `project-template/`・`project-template.zip`（ビルド成果物、`.gitignore`対象、コミット不要）。テンプレートにADRは同梱しない
- Claude Code/Codex双方への適合が済んでいる（`.agents/skills/`、`CLAUDE.md`）
- 配置のズレ（`.dev/handoff.md`ではなくルート直下にあった等、作業環境固有の残骸）を今回のGitHub管理の検討で発見し修正した

## なぜそうしているか (Why)

（現時点で特筆すべき新しい理由なし。個々の理由はknowledge・documentation-rules・凍結ADRに記載済み）

## 人間からの申し送り事項 (Human → AI)

（現在なし）

## 未決事項・懸念

- Handoff自体が作業ログ化していた（直前は60行・9.6KB）。今回「今の状態」のみに圧縮したが、再発防止の運用ルールは未検討（次に扱う論点）
- discussion-rulesは未決定・保留の扱いに内容が偏っている。トリガー: 該当する知見が実際に繰り返し必要になった時（`.dev/scratch/discussion-rules-scope-gap.md`）
- scratchにおける時系列記録の例外は仮運用のまま、該当事例なし
- `skills/*/SKILL.md`に追加した`type: skill`・`updated`フィールドは仮
- Windows環境での`.claude/skills`作成可否、Claude CodeのAGENTS.md対応状況は未確認（トリガーはADR-0012を書き写した内容としてAGENTS.mdに明記済み）
- flat-fileチケットツール導入要否は保留。トリガー: ローカルでのGitHub往復が実際に摩擦になるか
- Handoffテンプレートは単一の作業スレッドのみを想定。複数スレッド並行時の構成は未検証
- `.dev/todo.md`をgitで管理するか（.gitignore対象にするか）は未決定

## 次にやること

1. Handoffの作業ログ化の再発防止ルールを検討する
