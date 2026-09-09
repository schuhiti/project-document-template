---
type: scratch
updated: 2026-09-09
---
# 決定と経緯の接続、検討中

`documentation-rules`の「決定・経緯の記録」に4条件と不変化の扱いを入れた。残っている論点と、既存文書の未処理分をここに置く。

## 残る論点

- **孤立検査の実装**。経緯記録が存在するのにどこからも指されていない状態は機械的に検出できる（`check-index-sync.sh`と同じ形）。差分ベース（ポインタを削る編集を捉える）か、セッション境界の全走査か未定。孤立の原因は「退役した」「張り忘れた」「もともと反映先を持たない」の3通りあり、機械的に無効とは結論できないので、検出結果は人間の判断にかける。トリガー: 経緯記録が5本を超えて手作業での確認が現実的でなくなった時
- **経緯ポインタの粒度**。文書単位か節単位か。節単位は精度が高いが、節の再構成のたびに落ちる。トリガー: 実際にポインタが落ちた事例が出た時
- **不変化した記録の置き場所**。rootは`docs/adr/`に連番の凍結13本があり、そこへ日付+スラグの新しい記録を混ぜることになる。索引はStatus列を持つ行と持たない行が混在する。実際に1本目を移す時に、混在のまま進めるか分けるかを決める
- **経緯が無い決定について後から根拠を問われた回数**。事前に経緯を付けるべき範囲を広げるかどうかの判断材料になる。観測可能なので数える

## 4条件を満たしていない既存文書

`docs/knowledge/`の実測（2026-09-09）。分割・抽出が要るもの。

- `pretooluse-hook-limits.md`: 「commit前に`git diff --staged`を読む習慣」がこの文書1箇所にしか無く、生きた文書へ抽出されていない（条件2違反）。凍結すると運用ごと過去側に取り残される
- `root-template-sync.md`: 前半がビルド方式への設計変更とその理由（決定）、後半がroot専用ファイルの一覧と共有ファイルの注意（現況）。文書単位では不変にできない（条件3違反）
- `hook-distribution-policy.md`: Codex互換hookの見送りがトリガー付きでこの文書の中にあり、対応する`scratch`が無い（条件4違反）

## 到達可能性の実測（2026-09-09）

`index.md`と`.dev/handoff.md`を除いた、生きた文書からのポインタの有無。handoffは完全上書きするのでポインタの置き場所にならない。

| 文書 | ポインタ元 |
|---|---|
| root-template-sync | `documentation-rules/SKILL.md`、README.md |
| tool-neutrality-scope | README.md |
| stop-hook-boundary-mismatch | `session-boundary-reminder.sh` |
| adr-retirement | `docs/adr/index.md` |
| hook-distribution-policy | knowledge同士のみ |
| pretooluse-hook-limits | knowledge同士のみ |
| claude-skills-setup-script | なし |

7本中3本しか規範を持つ文書から指されていない。`claude-skills-setup-script.md`は次にhandoffを上書きした時点で索引以外から到達できなくなる。
