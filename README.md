# agents-conventions

Single source of truth for AI coding agent instructions (Java/Kotlin, Playwright, etc.).
Uses [Ruler](https://github.com/intellectronica/ruler) to distribute rules to all configured agents automatically.

## Setup

```bash
npm install -g @intellectronica/ruler
```

## Usage

1. Create or edit a `.md` file in `.ruler/` with the appropriate prefix (e.g. `08_something.md`)
2. Run `./apply-to-global.sh` — regenerates and copies to all global agent configs:
   - `~/.claude/CLAUDE.md` — Claude Code
   - `~/.codex/AGENTS.md` — Codex CLI
   !!! Its not good due to copy some into user settings ( apply-to-global.sh do that) but This is my flow. I dont want to run `ruler apply` in each project
3. Commit `.ruler/`


## Ruler commands
Preview changes without writing:

```bash
ruler apply --dry-run --verbose
```

Undo all generated files:

```bash
ruler revert
```

## Structure

```
.ruler/
  ruler.toml                # which agents to target
  00_role.md                # identity and core principles
  01_code_style.md          # formatting, imports, annotations
  02_java.md                # Lombok, injection, validation
  03_kotlin.md              # val/var, data class, extension functions
  04_testing.md             # naming, given/when/then structure
  05_maven.md               # versions, build workflow
  06_change_presentation.md # how to present diffs and changes
  07_playwright.md          # locators, input, assertions
```

Files are concatenated in alphabetical order of their filenames.
To control the sequence intentionally, use zero-padded numeric prefixes (00_, 01_, 02_ …)
Rules that appear earlier in the concatenated text usually take precedence over rules that come later.


## SKILLS
### browser
```bash
npm install -g @playwright/cli@latest
playwright-cli install --skills
```