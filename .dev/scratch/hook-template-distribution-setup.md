---
type: scratch
status: 検討中
updated: 2026-08-31
---
# 検討: hookのテンプレート配布の実装方法

[docs/knowledge/hook-distribution-policy.md](../../docs/knowledge/hook-distribution-policy.md)で方針（jq依存許容・無ければ設定しない、Stop hookは配布しない）は決めたが、具体的な実装は未着手。

論点:
- frontmatter必須・handoff行数目安・index.md整合（PostToolUseの3種）を`.dev/template-src/`へ追加するか。追加する場合、`.dev/build-template.sh`のSHARED_FILES/template-srcのどちらに置くか
- `jq`の有無に応じた条件付きセットアップをどう実現するか: SETUP.mdに前提条件として書くだけで済ませるか、チェック＋コピーを行うセットアップスクリプトを別途用意するか
- Codex（`apply_patch`をmatcherにした同種hook）への互換性スクリプトをどの程度用意するか。[docs/knowledge/tool-neutrality-scope.md](../../docs/knowledge/tool-neutrality-scope.md)の方針（互換レイヤー開発は主目的としない）とのバランス

トリガー: 上記いずれかに着手する具体的な必要が生じた時。
