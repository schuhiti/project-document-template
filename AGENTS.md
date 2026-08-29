# AGENTS.md

本ファイルを正本とする（ツール固有のファイルをそれぞれ正本にすると、内容の二重管理が発生するため）。Claude Code用には`CLAUDE.md`（`@AGENTS.md`のみをインポート。シンボリックリンク方式はWindowsで管理者権限を要するため避けた）を用意している。

本文は最小限に保ち、詳細は各ドキュメントへのポインタに留める。

前提: `docs/premise.md` が存在しない場合、先に `SETUP.md` を実行してから以降の内容に従う。

## セッション開始・再開時に必ず行うこと
1. `docs/premise.md` を読む
2. `.dev/handoff.md` が存在すれば読む（前回セッションからの引き継ぎ状態）
3. 2で内容の食い違いに気づいた場合、現在の作業状況については `.dev/handoff.md` を優先する。前提や決定そのものが食い違って見える場合、機械的にどちらかを正としない。各文書の`updated`を手がかりにしつつ、食い違いを人間に報告して確認を仰ぐ。人間がすぐに応答しない場合、食い違いに関係しない作業は進めてよいが、食い違いに依存する判断は保留する
4. `.claude/skills` が無ければ作る: `mkdir -p .claude && ln -s ../.agents/skills .claude/skills`。**Windowsで管理者権限が無く、開発者モード（設定 > 更新とセキュリティ > 開発者向け > 開発者モード）も無効な場合、`ln -s`は真のシンボリックリンクを作らず、エラーも出さずに`.agents/skills`と無関係な独立コピーを作ってしまう**（1でシンボリックリンク方式を避けた理由と同じ制約）。実行後は必ず`[ -L .claude/skills ]`で真のシンボリックリンクか検証する。真であれば、以後の環境でも再現するようgitへのコミットを推奨する（Linux/macOSはリンクがそのままコミットできる）。偽であれば直ちに`.claude`ごと削除し、権限・開発者モードが無い旨を記録した上で、作成できる環境で再確認する。Claude CodeがAGENTS.mdへ直接対応する等、ツールの対応状況が変わった場合はこの項目全体を見直す

## ドキュメントの参照先

| 種別 | type値 | 場所 | 参照タイミング |
|---|---|---|---|
| プロジェクト前提 | `premise` | `docs/premise.md` | 常時 |
| 決定とその理由 | `adr` | `docs/adr/` | 関連作業時 |
| 判断も手順も伴わない確定した内容（ドメイン概念・外部APIの癖・自システムの設計内容等） | `knowledge` | `docs/knowledge/` | オンデマンド |
| 検討メモ | `scratch` | `.dev/scratch/` | オンデマンド（`.dev/handoff.md`のポインタ経由） |
| 手順・ルール（議論の進め方／文書化の判断／設計実装の作法） | `skill` | `.agents/skills/`（SKILL.md）。Claude Code用の`.claude/skills`は「必ず行うこと」4を参照 | 該当タスク時 |
| 引き継ぎ状態 | `handoff` | `.dev/handoff.md` | セッション開始・再開時 |
| セッション内の実行項目 | `todo` | `.dev/todo.md` | セッション内で自由に |
| 索引 | `index` | 各ディレクトリの`index.md` | オンデマンド |
| 実行項目・状態（doneが明確でセッションをまたぐもの） | — | GitHub Issues | 作業計画時 |
| 未決着の議論 | — | GitHub Discussions | 該当議論時 |

## 文書を書く際の原則
→ `.agents/skills/documentation-rules/SKILL.md` を参照。議論の進め方は `.agents/skills/discussion-rules/SKILL.md` を参照。
