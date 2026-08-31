# AGENTS.md

エージェント向けの指示は本ファイルに書く。本文は最小限に保ち、詳細は各ドキュメントへのポインタに留める。

Claude Code用の`CLAUDE.md`のように他ツール固有のファイルが必要な場合も、内容を複製せず本ファイルを参照するだけにする（現に`CLAUDE.md`は`@AGENTS.md`のみをインポートしている）。シンボリックリンクにしなかったのはWindowsでの管理者権限要件のため（同じ制約は4を参照）。

前提: `docs/premise.md` が存在しない場合、先に `SETUP.md` を実行してから以降の内容に従う。

## セッション開始・再開時に必ず行うこと
1. `docs/premise.md` を読む
2. `.dev/handoff.md` が存在すれば読む（前回セッションからの引き継ぎ状態）
3. 2で食い違いに気づいた場合、現在の作業状況は `.dev/handoff.md` を優先する。前提や決定そのものが対象なら、機械的にどちらかを正とせず、各文書の`updated`を手がかりに人間へ報告して確認を仰ぐ。すぐに応答が無ければ、無関係な作業は進めてよい
4. `.claude/skills` が無ければ作る: `mkdir -p .claude && ln -s ../.agents/skills .claude/skills` を実行し、`[ -L .claude/skills ]`で真のリンクか検証する。偽であれば`.claude/skills`を削除する。Windowsでは削除後に`powershell.exe -Command "New-Item -ItemType Junction -Path '<絶対パス>\.claude\skills' -Target '<絶対パス>\.agents\skills'"`（絶対パスは`cygpath -w`等でリポジトリルートから求める。ジャンクションは相対パス非対応のため必須）でジャンクション作成を試す。これも失敗する場合のみ、管理者権限・開発者モード・ジャンクション作成権限のいずれも無い旨を記録した上で作成できる環境で再確認する。真のリンクまたはジャンクションが作れれば、Linux/macOSはそのままコミットする。Windowsではコミットせず、`.git/info/exclude`に該当行が無ければ追記した上で、セッションごとにその場で作り直す（暫定運用）。理由: Windowsで管理者権限・開発者モードが無いと`ln -s`はエラーを出さず独立コピーを作ってしまう（冒頭でCLAUDE.mdをシンボリックリンクにしなかった理由と同じ制約）ため事後検証が必須。ジャンクションは管理者権限・開発者モードが無くても作成できるため`ln -s`失敗時の代替になるが、絶対パスしか受け付けない。いずれの方式でコミットしても、真のリンクは`core.symlinks=false`の環境で正しく取り出せず、ジャンクションは絶対パス依存のため別の場所へチェックアウトすると壊れる。偽の場合に`.claude`ごとでなく`.claude/skills`だけを削除するのは、`.claude`配下に他のコミット対象（設定・hook）があるため。除外を共有の`.gitignore`でなく`.git/info/exclude`に置くのは、Linux/macOSでのコミットを妨げないため。見直し条件: Claude CodeがAGENTS.mdへ直接対応する等、ツールの対応状況が変わった場合

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
