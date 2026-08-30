---
type: handoff
updated: 2026-08-30
---
# Handoff — AIエージェント運用のための文書体系・整備

配置: `.dev/handoff.md`（完全上書き運用。テンプレート: `.dev/handoff-template.md`）

## 今どこまで進んだか (What)

文書体系は一通り完成している。

- 種別: premise/adr/knowledge/skill/scratch/handoff/template/index/todo（GitHub Issues/Discussionsと併用）
- ADRは新規作成を終了した（`docs/knowledge/adr-retirement.md`）。既存13本は`docs/adr/`に凍結し、内容は生きた文書へ書き写し済み。以後の決定は反映先に理由を直接書き添え、却下案は分量に応じて`scratch`（未確定）か`knowledge`（確定済み）へ
- `.dev/notes/`（人間専用メモ）は必要性が無かったため削除済み
- テンプレート配布は`.dev/template-src/`（一次情報: SETUP.md・テンプレート版docs/index.md・AGENTS.md・docs/system.md）+ rootの共有ファイル（CLAUDE.md等） → `.dev/build-template.sh`（zip作成は`zip`優先、Windowsでは`powershell.exe`の`Compress-Archive`へフォールバック） → `project-template/`・`project-template.zip`（ビルド成果物、`.gitignore`対象、コミット不要）。テンプレートにADRは同梱しない
- root版`AGENTS.md`とテンプレート版は内容が異なる: root版はこのプロジェクト自身の文書体系フレームワークそのもの（このプロジェクトにとって正しい構成のため無変更）。テンプレート版は「プロジェクト固有の指示を書く薄いAGENTS.md」＋「ドキュメント運用ルール本体のdocs/system.md」に分割済み（配布先プロジェクトが自分固有のAGENTS.md慣習と衝突しないようにするため。分割は自動生成ではなく手動維持。`docs/knowledge/root-template-sync.md`参照）
- Claude Code/Codex双方への適合が済んでいる（`.agents/skills/`、`CLAUDE.md`）。`.claude/skills`のWindows対応も決着済み: 管理者権限・開発者モードが無い環境では`ln -s`がエラーなく独立コピーを作ってしまうため`[ -L ]`で検証し、Windowsでは`.gitignore`で除外してセッションごとに作り直す運用（AGENTS.md「必ず行うこと」4＝配布版では`docs/system.md`の4に反映済み）
- 生きた文書（SKILL.md・document-types.md・docs/index.md）からの装飾的なADR番号引用は整理済み。scratchの2ファイルにあった「skill昇格基準」の誤引用（正しい参照先はADR-0004ではなく`document-types.md`のskill行）も修正済み
- documentation-rulesに「文章構造の原則」（手順と理由を分離する、自明な補集合を重ねて書かない、主題語の反復を避ける、実装手段の詳細を二重に書かない）を追加済み

## なぜそうしているか (Why)

（現時点で特筆すべき新しい理由なし。個々の理由はknowledge・documentation-rules・凍結ADRに記載済み）

## 人間からの申し送り事項 (Human → AI)

（現在なし）

## 未決事項・懸念

- discussion-rulesは未決定・保留の扱いに内容が偏っている。トリガー: 該当する知見が実際に繰り返し必要になった時（`.dev/scratch/discussion-rules-scope-gap.md`）
- scratchにおける時系列記録の例外は仮運用のまま、該当事例なし
- `skills/*/SKILL.md`に追加した`type: skill`・`updated`フィールドは仮
- flat-fileチケットツール導入要否は保留。トリガー: ローカルでのGitHub往復が実際に摩擦になるか
- Handoffテンプレートは単一の作業スレッドのみを想定。複数スレッド並行時の構成は未検証
- `.dev/todo.md`をgitで管理するか（.gitignore対象にするか）は未決定
- Handoffの作業ログ化（過去に一度発生）の再発有無を保留・観察中。原因はチャット上でSkill未適用だったためと判明済み。トリガー: 再発したらその時点で構造的な対応を検討する

## 次にやること

（現在なし）
