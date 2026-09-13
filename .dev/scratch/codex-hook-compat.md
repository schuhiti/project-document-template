---
type: scratch
status: 検討中
updated: 2026-09-13
---
# 検討: Codex向けhook対応

確定した配布方針と実行経路は、[hook-distribution-policy.md](../../docs/knowledge/hook-distribution-policy.md)と[root-template-sync.md](../../docs/knowledge/root-template-sync.md)を参照する。

## 未解決事項

- Windows版Codex Desktopが、信頼済みの`PostToolUse` hookを実際に実行しているか。`additionalContext`は画面表示ではなくモデル向けなので、作業ログだけでは判定できない。
- Desktopのhook信頼状態がプロジェクト単位で保持されるのか、設定変更時に再確認を省略する仕様なのか。
- CLIまたはDesktopで、信頼済みhookの実行結果を観測できる確認方法があるか。

Codexの公式実装では、プロジェクト層の`.codex/config.toml`にある`hooks`と、同じ`.codex/`の`hooks.json`をどちらも読み込む。両方にhookがある場合は警告されるため、現在のJSON形式を維持し、`config.toml`へ移行しない。

Codexの`PreCompact`は`hookSpecificOutput.additionalContext`に対応しないため、現在の設定には登録しない。

## 確認時の条件

Windowsでは`bash`を名前だけで実行せず、Git Bashの絶対パスを使う。Linuxでは標準の`bash`を使う。どちらも`jq`と`git`が必要である。
