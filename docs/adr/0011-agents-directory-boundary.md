---
type: adr
status: accepted
updated: 2026-08-29
---
# ADR-0011: `.agents/`配下全体を外部規約の管轄として本Skillの規約から除外する

## Context
ADR-0010で`.agents/skills/`をSkillの実体の置き場所とした際、documentation-rulesの対象外規定は`AGENTS.md`と`.agents/skills/*/SKILL.md`という文書レベルの列挙のみで、`.agents/`というディレクトリ階層そのものが外部規約（Agent Skills / AGENTS.mdエコシステム）の管轄である、という意図を書いていなかった。結果、`.agents/skills/index.md`が本Skillの規約（frontmatter・index.md）にそのまま従って作成されており、隣接する`.agents/skills/*/SKILL.md`（対象外）と`.agents/skills/index.md`（対象内）が矛盾する扱いを受けていた。加えて、Agent Skillsの規約が定めるのは`<skills-dir>/<name>/SKILL.md`という構造であり、`skills/`直下に規約外のファイルを置いた場合の各ツールの挙動は未確認である。

## Decision
`.agents/`配下全体を、本Skillのfrontmatter・index.md規約の対象外とする。個々のファイルではなくディレクトリ階層単位での除外とする。`.agents/skills/index.md`は削除する。`SKILL.md`のみ、横断検索のため`type: skill`・`updated`を引き続き付与する（既存の扱いを変えない）。

## Consequences
`.agents/`配下の構造は完全にAgent Skills / AGENTS.mdエコシステムの規約のみに従う。一方、本Skillのdocumentation-rulesが提供していた索引（`.agents/skills/`配下に何があるか一覧できる`index.md`）は失われる。個々のSkillの内容はSKILL.mdの`description`が代替する。

## Alternatives Considered
`.agents/skills/index.md`を残したまま「対象外だが例外的に置いてよい」とする案は、対象外の定義自体を曖昧にするため却下した。
