# ドキュメント運用のルール

`AGENTS.md`から参照される。本文は最小限に保ち、詳細は各ドキュメントへのポインタに留める。

## セッション開始・再開時に必ず行うこと
1. `docs/premise.md` を読む
2. `.dev/handoff.md` が存在すれば読む（前回セッションからの引き継ぎ状態）
3. 2で食い違いに気づいた場合、現在の作業状況は `.dev/handoff.md` を優先する。前提や決定そのものが対象なら、機械的にどちらかを正とせず、各文書の`updated`を手がかりに人間へ報告して確認を仰ぐ。すぐに応答が無ければ、無関係な作業は進めてよい
4. `bash .claude/setup-skills.sh` を実行する（`.claude/skills`のセットアップ。既に有効なら即終了する）。非ゼロで終了したら自己判断で回避せず、エラー内容をそのまま人間に報告して指示を仰ぐ。Skillを読めない状態のまま作業を続けると、本Skill体系の前提が成立しない

## ドキュメントの参照先

| 種別 | type値 | 場所 | 参照タイミング |
|---|---|---|---|
| プロジェクト前提 | `premise` | `docs/premise.md` | 常時 |
| 決定とその理由 | `adr` | `docs/adr/` | 関連作業時 |
| 判断も手順も伴わない確定した内容（ドメイン概念・外部APIの癖・自システムの設計内容等） | `knowledge` | `docs/knowledge/` | オンデマンド |
| 検討メモ | `scratch` | `.dev/scratch/` | オンデマンド（`.dev/handoff.md`のポインタ経由） |
| 手順・ルール（議論の進め方／文書化の判断／文体／設計実装の作法） | `skill` | `.agents/skills/`（SKILL.md）。Claude Code用の`.claude/skills`は「必ず行うこと」4を参照 | 該当タスク時 |
| 引き継ぎ状態 | `handoff` | `.dev/handoff.md` | セッション開始・再開時 |
| セッション内の実行項目 | `todo` | `.dev/todo.md` | セッション内で自由に |
| 索引 | `index` | 各ディレクトリの`index.md` | オンデマンド |
| 実行項目・状態（doneが明確でセッションをまたぐもの） | — | GitHub Issues | 作業計画時 |
| 未決着の議論 | — | GitHub Discussions | 該当議論時 |

## 文書を書く際の原則
→ `.agents/skills/documentation-rules/SKILL.md` を参照。議論の進め方は `.agents/skills/discussion-rules/SKILL.md`、文体は `.agents/skills/writing-style-rules/SKILL.md` を参照。
