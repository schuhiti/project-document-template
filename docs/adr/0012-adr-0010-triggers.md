---
type: adr
status: accepted
updated: 2026-08-29
---
# ADR-0012: ADR-0010の未確認事項に再検討トリガーを補う

## Context
ADR-0010は「Windows環境では管理者権限が必要な場合がある」「Claude CodeはAGENTS.md対応予定なし（2026年8月時点）」という2点を未確認・現状のまま残したが、discussion-rulesが要求する再検討のトリガー条件を明示していなかった。ADR本文は不変のため、ADR-0010自体は修正せず、本ADRで補う。

## Decision
- Windowsでのシンボリックリンク作成可否: 実際にWindows環境でこの構成を使う時に確認する
- Claude CodeのAGENTS.md対応状況: ツールのメジャーアップデート時、または`.claude/skills`シンボリックリンクの運用で問題に気づいた時に再確認する

## Consequences
2つの未確認事項が、曖昧な「未確認のまま」ではなく、再検討すべきタイミングを持つ状態になる。

## Alternatives Considered
ADR-0010を直接修正する案は、本文不変の原則を保つため却下した。
