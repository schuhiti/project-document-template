---
type: handoff
updated: 2026-09-09
---
# Handoff — AIエージェント運用のための文書体系・整備

配置: `.dev/handoff.md`（完全上書き運用。テンプレート: `.dev/handoff-template.md`）

## 今どこまで進んだか (What)

- リポジトリ状態: `main` / `80d9425` / 作業ツリーはクリーン、originへpush済み
- 文書体系は一通り完成している。種別・置き場所・運用ルールは`AGENTS.md`のドキュメント参照表と`.agents/skills/documentation-rules/`が正本
- 決定と経緯を分けて記録するルールを整備した。経緯記録が4条件（選択の記録のみ・運用は生きた文書側・現況を含めない・保留を含めない）を満たした時点で`adr`として不変にする。ADRは経緯であって正本ではなく、規範の出所としては引用しない
- 上記に伴い`docs/knowledge/`の3件を分割し、1本目の`docs/adr/2026-08-30-template-build-from-source.md`が生まれた。連番の凍結13本と同じディレクトリ・同じ索引に混在させている
- 決定の記録の孤立を検出する`.claude/hooks/check-adr-orphan.sh`を追加した（PostToolUseは4種になり、テンプレートへも配布済み）
- 進行中の検討: `.dev/scratch/index.md`の6本

## なぜそうしているか (Why)

（個々の理由は`docs/knowledge/`・documentation-rules・`docs/adr/`に記載済み）

## 人間からの申し送り事項 (Human → AI)

（現在なし）

## 未決事項・懸念

- 決定と経緯の接続に残る論点（`.dev/scratch/decision-provenance.md`）。経緯ポインタの粒度、経緯の無い決定について根拠を問われた回数の観測、hookがBash経由の編集を捉えないこと
- Codex向けhookの互換実装は保留（`.dev/scratch/codex-hook-compat.md`）
- discussion-rulesは未決定・保留の扱いに内容が偏っている（`.dev/scratch/discussion-rules-scope-gap.md`）
- scratchにおける時系列記録の例外は仮運用のまま、該当事例なし（`.dev/scratch/scratch-timeseries-recording.md`）
- 繰り返される操作のスクリプト化を検討中、まだ3回以上の実例は無い（`.dev/scratch/repeated-operations-scripting.md`）
- 想定する作業の6フェーズモデルの妥当性が未検証（`.dev/scratch/six-phase-model.md`）
- `skills/*/SKILL.md`に追加した`type: skill`・`updated`フィールドは仮
- flat-fileチケットツール導入要否は保留。トリガー: ローカルでのGitHub往復が実際に摩擦になるか
- Handoffテンプレートは単一の作業スレッドのみを想定。複数スレッド並行時の構成は未検証
- `.dev/todo.md`をgitで管理するか（`.gitignore`対象にするか）は未決定
- Handoffの作業ログ化が再発した。前回までの「今どこまで進んだか」は過去の変更を積み増す形になっていた。今回全面的に書き直したが、「再発したら構造的な対応を検討する」というトリガーは発火済みで、対応は未着手。行数hookは閾値60行に対し56行だったため、1行が長い形の肥大化を捉えられていない

## 次にやること

（現在なし）
