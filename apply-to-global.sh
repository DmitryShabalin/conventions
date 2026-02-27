#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Applying ruler..."
cd "$SCRIPT_DIR"
ruler apply

echo "Copying to global agent configs..."

# Claude Code — ~/.claude/CLAUDE.md
mkdir -p ~/.claude
cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
echo "  Claude Code -> ~/.claude/CLAUDE.md"

# Codex CLI — ~/.codex/AGENTS.md
mkdir -p ~/.codex
cp "$SCRIPT_DIR/AGENTS.md" ~/.codex/AGENTS.md
echo "  Codex CLI   -> ~/.codex/AGENTS.md"

echo "Done."
