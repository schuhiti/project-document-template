---
type: handoff
updated: 2026-09-09
---
# Handoff — AIエージェント運用のための文書体系・整備

配置: `.dev/handoff.md`（完全上書き運用。テンプレート: `.dev/handoff-template.md`）

## 今どこまで進んだか (What)

- リポジトリ状態: `main` / `68a96b5` / 作業ツリーはクリーン、originへpush済み（記載時点）
- 文書体系は一通り完成している。種別・置き場所・運用ルールは`AGENTS.md`のドキュメント参照表と`.agents/skills/documentation-rules/`が正本
- 進行中の検討: `.dev/scratch/index.md`の6本

## なぜそうしているか (Why)

（個々の理由は`docs/knowledge/`・documentation-rules・`docs/adr/`に記載済み）

## 人間からの申し送り事項 (Human → AI)

（現在なし）

## 未決事項・懸念

対応する`.dev/scratch/`のファイルがあるものは`.dev/scratch/index.md`が持つ。ここには置き場所が無いものだけを書く。

- `skills/*/SKILL.md`に追加した`type: skill`・`updated`フィールドは仮
- flat-fileチケットツール導入要否は保留。トリガー: ローカルでのGitHub往復が実際に摩擦になるか
- Handoffテンプレートは単一の作業スレッドのみを想定。複数スレッド並行時の構成は未検証
- `.dev/todo.md`をgitで管理するか（`.gitignore`対象にするか）は未決定

## 次にやること

（現在なし）
