---
type: knowledge
tags: [structure, decision, hook]
updated: 2026-09-13
---
# hookのフレームワーク配布方針

Claude CodeのPostToolUse検査とStopの`sweep-doc-checks.sh`を配布する。Codexでは`.codex/hooks.json`から`apply_patch`後に同じ検査スクリプトを呼び出す。Linuxでは標準の`bash`、WindowsではGit Bashの絶対パスを使う。Windowsの`bash`を名前だけで呼ぶとWSLランチャーが選ばれるため、Windows用のhook設定では絶対パスを指定する。ビルド上の構成は[root-template-sync.md](root-template-sync.md)が持つ。

- `jq`依存は許容する。`jq`が無い環境向けの条件分岐はスクリプト化せず、`SETUP.md`にhook設定を削除する手順を追記するだけに留めた（配布フロー自体が手作業前提のため、専用のインストールスクリプトは今の規模に見合わない）
- メッセージの日本語固定は許容する。このプロジェクトの第一ユーザーは作成者本人であるため
- Claude Codeのセッション境界リマインダー（`session-boundary-reminder.sh`、PreCompact。Stopでの運用は廃止した経緯は`docs/knowledge/stop-hook-boundary-mismatch.md`参照）はテンプレートへ配布せず、root専用の運用に留める。CodexのPreCompact出力には`hookSpecificOutput`がないため、Codex設定には登録しない
- Codexでは既存スクリプトを再利用し、`.codex/hooks.json`だけをネイティブ形式で追加する。Claude Codeとの共通設定や変換処理は作らない
- Windowsのアクセス権設定とhookの信頼登録が必要なため、初回導入時に通常のコマンド実行とhook発火を確認する。Desktopで発火を確認できない環境では、動作を保証せず保留する（経緯は`.dev/scratch/codex-hook-compat.md`）
