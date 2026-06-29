#!/usr/bin/env bash
#
# solana-brain installer — drop the brain into any Solana repo (or install user-wide).
#
# One-liner (curl | bash):
#   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash -s -- --user
#
# From a clone:
#   ./install.sh                 # install into the current project (./.claude)
#   ./install.sh --user          # install into ~/.claude (all projects)
#   ./install.sh --project DIR   # install into DIR/.claude
#   ./install.sh -y              # don't prompt
#
# Installs:
#   <target>/.claude/skills/solana-brain/   (skill/ + rules/ + CLAUDE.md)
#   <target>/.claude/agents/*.md            (chief-of-staff + 5 cluster leads)
#   <target>/.claude/commands/*.md          (/brain, /company-setup, /ship-it, /launch-token, /raise, /incident)
# …and appends the brain-first protocol to <target>/CLAUDE.md (project installs).
#
# No build step, no runtime dependencies. Read-only / key-safe — never asks for a key.
set -euo pipefail

REPO_URL="${SOLANA_BRAIN_REPO:-https://github.com/Sushant6095/solana-brain}"
SKILL_NAME="solana-brain"
ASSUME_YES=0
SCOPE="project"      # project | user
TARGET="$(pwd)"

while [ $# -gt 0 ]; do
  case "$1" in
    -y) ASSUME_YES=1 ;;
    --user) SCOPE="user" ;;
    --project) SCOPE="project"; TARGET="${2:?--project needs a dir}"; shift ;;
    -h|--help) sed -n '2,30p' "$0"; exit 0 ;;
    *) echo "unknown arg: $1" >&2; exit 1 ;;
  esac
  shift
done

# Resolve source: run-from-clone if this script sits next to skill/, else clone to a temp dir.
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || echo "")"
CLEANUP=""
if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR/skill" ]; then
  command -v git >/dev/null 2>&1 || { echo "git required to fetch $REPO_URL" >&2; exit 1; }
  SRC_DIR="$(mktemp -d)"; CLEANUP="$SRC_DIR"
  echo "Fetching solana-brain from $REPO_URL …"
  git clone --depth 1 "$REPO_URL" "$SRC_DIR" >/dev/null 2>&1
fi
trap '[ -n "$CLEANUP" ] && rm -rf "$CLEANUP"' EXIT

if [ "$SCOPE" = "user" ]; then
  CLAUDE_DIR="${CLAUDE_HOME:-$HOME/.claude}"
else
  CLAUDE_DIR="$TARGET/.claude"
fi
SKILL_DEST="$CLAUDE_DIR/skills/$SKILL_NAME"

confirm() { [ "$ASSUME_YES" -eq 1 ] && return 0; printf "%s [y/N] " "$1"; read -r a || true; case "$a" in [yY]*) return 0;; *) return 1;; esac; }

echo "Installing '$SKILL_NAME' ($SCOPE scope) → $CLAUDE_DIR"
[ -d "$SKILL_DEST" ] && { confirm "  Overwrite existing $SKILL_DEST?" || { echo "aborted"; exit 0; }; rm -rf "$SKILL_DEST"; }

mkdir -p "$SKILL_DEST" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/commands"
cp -R "$SRC_DIR/skill/." "$SKILL_DEST/"
cp -R "$SRC_DIR/rules" "$SKILL_DEST/rules"
cp "$SRC_DIR/CLAUDE.md" "$SKILL_DEST/CLAUDE.md"
cp -f "$SRC_DIR/agents/"*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
cp -f "$SRC_DIR/commands/"*.md "$CLAUDE_DIR/commands/" 2>/dev/null || true

# Inject the brain-first protocol into the project's CLAUDE.md (project scope only).
inject_protocol() {
  local md="$1"
  local marker="<!-- solana-brain:brain-first -->"
  grep -qF "$marker" "$md" 2>/dev/null && { echo "  brain-first protocol already present in $(basename "$md")"; return; }
  {
    echo ""
    echo "$marker"
    echo "## solana-brain — brain-first protocol"
    echo "Before improvising on any Solana task, route through the brain: classify with"
    echo "\`.claude/skills/$SKILL_NAME/skill/RESOLVER.md\` → open the matching cluster in"
    echo "\`.claude/skills/$SKILL_NAME/skill/clusters/\` → delegate depth to the specialist skill it names →"
    echo "respect gates (SECURE before ship/launch; OPERATE legal/tax before a token) → verify. See"
    echo "\`.claude/skills/$SKILL_NAME/skill/SKILL.md\`."
    echo "<!-- /solana-brain:brain-first -->"
  } >> "$md"
  echo "  appended brain-first protocol → $(basename "$md")"
}
if [ "$SCOPE" = "project" ]; then
  touch "$TARGET/CLAUDE.md"; inject_protocol "$TARGET/CLAUDE.md"
fi

echo
echo "Done. solana-brain installed."
echo "  skill    → $SKILL_DEST"
echo "  agents   → $CLAUDE_DIR/agents/ (chief-of-staff + build/ship/secure/grow/operate-lead)"
echo "  commands → $CLAUDE_DIR/commands/ (/brain /company-setup /ship-it /launch-token /raise /incident)"
echo
echo "Try in Claude Code:  /brain we want to launch a token next month"
echo "Read-only / key-safe — solana-brain never needs a private key; your wallet signs."
