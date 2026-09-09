---
type: scratch
updated: 2026-09-09
---
# 決定と経緯の接続、検討中

`documentation-rules`の「決定・経緯の記録」に4条件と不変化の扱いを入れた。残っている論点と、既存文書の未処理分をここに置く。

## 残る論点

- **孤立検査の実装**。経緯記録が存在するのにどこからも指されていない状態は機械的に検出できる（`check-index-sync.sh`と同じ形）。差分ベース（ポインタを削る編集を捉える）か、セッション境界の全走査か未定。孤立の原因は「退役した」「張り忘れた」「もともと反映先を持たない」の3通りあり、機械的に無効とは結論できないので、検出結果は人間の判断にかける。トリガー: 経緯記録が5本を超えて手作業での確認が現実的でなくなった時
- **経緯ポインタの粒度**。文書単位か節単位か。節単位は精度が高いが、節の再構成のたびに落ちる。トリガー: 実際にポインタが落ちた事例が出た時
- **経緯が無い決定について後から根拠を問われた回数**。事前に経緯を付けるべき範囲を広げるかどうかの判断材料になる。観測可能なので数える

決着した論点: 不変化した記録の置き場所は`docs/adr/`とし、連番の凍結13本と日付+スラッグの新しい記録を同じディレクトリ・同じ索引に混在させる。1本目（`2026-08-30-template-build-from-source.md`）で実際に混ぜて支障が無かった。索引はStatus列を空欄のまま使う

## 既存文書の分割（2026-09-09に実施）

- `pretooluse-hook-limits.md`（条件2）: 運用を`writing-style-rules`の「構成」へ移し、knowledge側は1行のポインタにした
- `root-template-sync.md`（条件3）: 決定と理由を`docs/adr/2026-08-30-template-build-from-source.md`へ抜き出し、knowledge側は構成の説明とポインタだけを持つ形にした。これが4条件による`adr`昇格の1件目
- `hook-distribution-policy.md`（条件4）: Codex互換hookの保留を`.dev/scratch/codex-hook-compat.md`へ移した。既存のセッション境界hookの検討と同じ論点なので統合した

`hook-distribution-policy.md`の条件3も解消した。配布構成の現況は`root-template-sync.md`へ統合し、knowledge側は決定と構成へのポインタだけを持つ。ただしCodex互換hookの保留をポインタで抱えているため条件4を満たさず、昇格はその保留が決着してから

## 到達可能性の実測（2026-09-09）

`index.md`と`.dev/handoff.md`を除いた、生きた文書からのポインタの有無。handoffは完全上書きするのでポインタの置き場所にならない。

| 文書 | ポインタ元 |
|---|---|
| root-template-sync | `documentation-rules/SKILL.md`、README.md |
| tool-neutrality-scope | README.md |
| stop-hook-boundary-mismatch | `session-boundary-reminder.sh` |
| adr-retirement | `docs/adr/index.md` |
| claude-skills-setup-script | AGENTS.md「必ず行うこと」4（今回追加） |
| hook-distribution-policy | root-template-sync.md（今回追加） |
| pretooluse-hook-limits | knowledge同士のみ |

`pretooluse-hook-limits.md`だけがknowledge同士からしか指されていない。反映先が共有ファイル（`writing-style-rules`）で、そこにroot専用のパスは書けないため、ポインタの置き場所が無い。root専用の決定の反映先が共有ファイルにある場合は索引が唯一の経路になる、という形で受け入れる。
