# hooks

Claude Code用のhookスクリプトを置く。どのhookをどのイベントに登録しているかは`.claude/settings.json`を、各スクリプトが何を確認するかはそれぞれの冒頭のコメントを参照する。

## 依存

- `bash`（WindowsではGit Bash）
- `jq`: すべてのスクリプトが、Claude Codeから受け取るJSONの読み取りに使う。`jq --version`が通らない環境では`.claude/settings.json`とこのディレクトリを削除する（残すとhookがエラーになる）
- `git`: `check-adr-orphan.sh`と`sweep-doc-checks.sh`が、確認するファイルの列挙に使う。git管理下でない場合、`check-adr-orphan.sh`は何も確認せず、`sweep-doc-checks.sh`は変更されたファイルを拾えない。どちらもエラーは出さない

## PostToolUseのhookを増減する時

`sweep-doc-checks.sh`（Stop）は、Write/Edit以外の経路で書き換えた文書をターン終了時に確認し直すため、PostToolUseのhookをスクリプト名で呼び直している。`.claude/settings.json`の登録内容は読まないので、PostToolUseにhookを足す・外す際は、この呼び出しも直すかを判断する。基準は同スクリプト冒頭のコメントにある。
