# agents-conventions

Single source of truth for AI coding agent instructions (Java/Kotlin, Playwright, etc.).
Uses [Ruler](https://github.com/intellectronica/ruler) to distribute rules to all configured agents automatically.

## Setup

```bash
npm install -g @intellectronica/ruler
```

## Usage

Edit rules in `.ruler/*.md`, then push to all global agent configs:

```bash
./apply-to-global.sh
```

This runs `ruler apply` and copies generated files to:
- `~/.claude/CLAUDE.md` — Claude Code (all projects)
- `~/.codex/AGENTS.md` — Codex CLI (all projects)

To only regenerate local files without copying:

```bash
ruler apply
```

Preview changes without writing:

```bash
ruler apply --dry-run --verbose
```

Apply to a specific agent only:

```bash
ruler apply --agents claude
ruler apply --agents cursor,copilot
```

Undo all generated files:

```bash
ruler revert
```

## Structure

```
.ruler/
  ruler.toml              # which agents to target
  AGENTS.md               # core JVM/Spring conventions
  java_convention.md      # Java-specific rules
  playwright_conventions.md  # Playwright test rules
```

## Adding new conventions

1. Create or edit a `.md` file in `.ruler/`
2. Run `ruler apply`
3. Commit `.ruler/` and any updated agent config files
