---
type: handoff
updated: 2026-08-31
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
- Claude Code/Codex双方への適合が済んでいる（`.agents/skills/`、`CLAUDE.md`）。`.claude/skills`のWindows対応も決着済み: 管理者権限・開発者モードが無い環境では`ln -s`がエラーなく独立コピーを作ってしまうため`[ -L ]`で検証し、Windowsでは`.git/info/exclude`（ローカル限定）で除外してセッションごとに作り直す運用（AGENTS.md「必ず行うこと」4＝配布版では`docs/system.md`の4に反映済み）
- 生きた文書（SKILL.md・document-types.md・docs/index.md）からの装飾的なADR番号引用は整理済み。scratchの2ファイルにあった「skill昇格基準」の誤引用（正しい参照先はADR-0004ではなく`document-types.md`のskill行）も修正済み
- documentation-rulesに「文章構造の原則」（手順と理由を分離する、自明な補集合を重ねて書かない、主題語の反復を避ける、実装手段の詳細を二重に書かない）を追加済み
- `tags`の用途をドメイン・性質による複数文書のグルーピングに限定し、共有先の無い一意の値（ファイル名の言い換え等）を禁止した
- scratch/knowledgeの見直し契機が「定期的」としか書かれておらず未定義だった問題を修正: scratchはセッション境界で`index.md`を確認、knowledgeは参照時に正しさを確認する、という具体的な手続きを`document-types.md`に追記した
- documentation-rulesの一部の規約（frontmatter必須・handoff行数目安・index.md整合）をClaude Codeのhookで機械チェックするようにした。`.claude/settings.json` + `.claude/hooks/*.sh`（PostToolUse 3種 + Stop/PreCompactのリマインダー1種）。あわせて`.gitignore`の`/.claude/`除外をシンボリックリンク（`skills`）・worktree・ローカル設定のみに絞り、`settings.json`/`hooks/`はコミット対象にした。Codex側は同種のhookが理論上可能（`apply_patch`をmatcherにする）だが今回は未着手、セッション境界hookは`.dev/scratch/codex-session-boundary-hook.md`参照で保留
- 上記により`.claude`がセッション開始時に空から作られる前提が崩れたため、AGENTS.md「必ず行うこと」4の破壊的フォールバック（真のリンクでない場合の削除範囲）を`.claude`ごと→`.claude/skills`のみに縮小した。テンプレート側（`.dev/template-src/docs/system.md`）はhookを配布していないため対象外で変更不要
- 上記の副産物として見つかった別件も対応済み: `.gitignore`が`/.claude/skills`をOS問わず一律除外しており、AGENTS.md「必ず行うこと」4の「Linux/macOSはそのままコミットする」という記述と矛盾していた。除外をWindows専用のローカル除外`.git/info/exclude`へ移し、共有`.gitignore`からは外した（Claude Code自身が`.claude/worktrees/`で同じ手法を既に使っていた前例に倣った）
- AGENTS.md「必ず行うこと」4を文章構造の原則（手順と理由の分離）に沿って整理した。手順中に埋め込んでいた理由節を末尾の「理由:」へ集約
- hookの実効性を洗い直した。`Stop`/`PreCompact`のexit 0出力（stdout/stderr）はデバッグログのみでClaudeに届かないと判明（公式ドキュメント・実機両方で確認）。`session-boundary-reminder.sh`を`hookSpecificOutput.additionalContext`形式に書き換えて修正済み（Stop/PreCompactとも対応、PreCompactでは圧縮後も内容が保持される）。さらにStopは毎ターン発火するため、作業ツリーがクリーンかつ`.dev/todo.md`が空なら鳴らさない条件を追加した
- `pre-commit-doc-reminder.sh`（PreToolUse、commit前チェック）は廃止した。PreToolUseは`additionalContext`非対応でブロックする以外にClaudeへ届ける手段が無く、ブロックすると同一条件で無限ループするため。理由と却下した代替案は`docs/knowledge/pretooluse-hook-limits.md`に記録し、対応するscratchは削除した。以後commit前の文書構造確認は習慣（`git diff --staged`を読む）で対応する
- hookのテンプレート配布を決定・実装した（`docs/knowledge/hook-distribution-policy.md`）: frontmatter必須・handoff行数目安・index.md整合の3種を配布（hookスクリプトはSHARED_FILES、settings.jsonはroot版と内容が違うため`.dev/template-src/.claude/settings.json`で個別管理）。Stop hookはroot専用のまま配布しない。`jq`が無い環境向けの条件分岐はスクリプト化せず`SETUP.md`への手順追記のみ。Codex互換hookは需要が出るまで見送り。あわせて「ツールに固定しない」前提が互換レイヤー開発を意味しない旨を`docs/knowledge/tool-neutrality-scope.md`・READMEに明記した
- `.claude/skills`セットアップ手順が肥大化していたため、プローズから`.claude/setup-skills.sh`へ切り出し、AGENTS.md/docs/system.mdの「必ず行うこと」4は1〜2行のポインタにした。失敗時の扱いも「記録して黙認」から「非ゼロ終了→人間に報告してブロック」へ強化した（`docs/knowledge/claude-skills-setup-script.md`）。あわせてClaude Code固定プロジェクト向けに`.agents/`を`.claude/`へリネームして一本化する選択肢を`SETUP.md`に追記した。build-template.shのSHARED_FILESに`.claude/setup-skills.sh`を追加し、再ビルドして動作確認済み
- `.gitattributes`（`*.sh text eol=lf`）を追加した。`core.autocrlf=true`環境で`.sh`をfetchするとCRLF化されbashが解釈できなくなる不具合を、実機で強制チェックアウトして再現・修正確認済み。SHARED_FILESに追加しテンプレートへも配布

## なぜそうしているか (Why)

（現時点で特筆すべき新しい理由なし。個々の理由はknowledge・documentation-rules・凍結ADRに記載済み）

## 人間からの申し送り事項 (Human → AI)

（現在なし）

## 未決事項・懸念

- discussion-rulesは未決定・保留の扱いに内容が偏っている。トリガー: 該当する知見が実際に繰り返し必要になった時（`.dev/scratch/discussion-rules-scope-gap.md`）
- scratchにおける時系列記録の例外は仮運用のまま、該当事例なし（`.dev/scratch/scratch-timeseries-recording.md`）
- 繰り返される操作のスクリプト化を検討中、まだ3回以上の実例は無い。トリガー: 同じ手作業を3回以上繰り返していると具体的に気づいた時（`.dev/scratch/repeated-operations-scripting.md`）
- 想定する作業の6フェーズモデルの妥当性が未検証。トリガー: 作業サイクルを何度か回した後に振り返る（`.dev/scratch/six-phase-model.md`）
- `skills/*/SKILL.md`に追加した`type: skill`・`updated`フィールドは仮
- flat-fileチケットツール導入要否は保留。トリガー: ローカルでのGitHub往復が実際に摩擦になるか
- Handoffテンプレートは単一の作業スレッドのみを想定。複数スレッド並行時の構成は未検証
- `.dev/todo.md`をgitで管理するか（.gitignore対象にするか）は未決定
- Handoffの作業ログ化（過去に一度発生）の再発有無を保留・観察中。原因はチャット上でSkill未適用だったためと判明済み。トリガー: 再発したらその時点で構造的な対応を検討する

## 次にやること

（現在なし）
