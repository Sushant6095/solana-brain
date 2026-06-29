#!/usr/bin/env bash
#
# solana-brain installer — onboard the brain into any Solana repo (or install user-wide).
#
# One-liner (curl | bash):
#   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash -s -- --user
#
# From a clone:
#   ./install.sh                 # onboard into the current project (./.claude)
#   ./install.sh --user          # onboard into ~/.claude (all projects)
#   ./install.sh --project DIR   # onboard into DIR/.claude
#   ./install.sh -y              # don't prompt (assume yes)
#   ./install.sh --fast          # skip the paced onboarding animation
#   ./install.sh --plain         # no color / no animation (also honors NO_COLOR)
#
# Installs:
#   <target>/.claude/skills/solana-brain/   (skill/ + rules/ + memory protocol + CLAUDE.md)
#   <target>/.claude/agents/*.md            (chief-of-staff + 5 cluster leads)
#   <target>/.claude/commands/*.md          (/brain /company-setup /ship-it /launch-token /raise /incident /recall /remember)
#   <target>/.solana-brain/                 (institutional memory — MEMORY.md, profile.md, decisions/)
# …and appends the brain-first protocol to <target>/CLAUDE.md (project installs).
#
# No build step, no runtime dependencies. Read-only / key-safe — never asks for a key.
set -euo pipefail

# ──────────────────────────────────────────────────────────────────────────────
# Config
# ──────────────────────────────────────────────────────────────────────────────
REPO_URL="${SOLANA_BRAIN_REPO:-https://github.com/Sushant6095/solana-brain}"
SKILL_NAME="solana-brain"
ASSUME_YES=0
SCOPE="project"          # project | user
TARGET="$(pwd)"
FAST=0
FORCE_PLAIN=0
spin_pid=""
CLEANUP=""

usage() {
  sed -n '3,22p' "$0" | sed 's/^# \{0,1\}//'
}

# ──────────────────────────────────────────────────────────────────────────────
# Args
# ──────────────────────────────────────────────────────────────────────────────
while [ $# -gt 0 ]; do
  case "$1" in
    -y|--yes)        ASSUME_YES=1 ;;
    --user)          SCOPE="user" ;;
    --project)       SCOPE="project"; TARGET="${2:?--project needs a dir}"; shift ;;
    --fast)          FAST=1 ;;
    --plain|--no-color) FORCE_PLAIN=1 ;;
    -h|--help)       usage; exit 0 ;;
    *) printf 'unknown arg: %s\n' "$1" >&2; exit 1 ;;
  esac
  shift
done

# ──────────────────────────────────────────────────────────────────────────────
# Capability detection — stdout drives color/animation, stdin drives prompts.
# (curl|bash: stdout is the terminal → animations on; stdin is the pipe → no prompts.)
# ──────────────────────────────────────────────────────────────────────────────
IS_TTY=0;      [ -t 1 ] && IS_TTY=1
INTERACTIVE=0; [ -t 0 ] && INTERACTIVE=1
COLOR=0; TRUECOLOR=0; UNICODE=0

if [ "$FORCE_PLAIN" -eq 0 ] && [ -z "${NO_COLOR:-}" ] && [ "$IS_TTY" -eq 1 ]; then
  ncolors="$(tput colors 2>/dev/null || echo 0)"
  case "${COLORTERM:-}" in
    truecolor|24bit) COLOR=1; TRUECOLOR=1 ;;
    *) if [ "${ncolors:-0}" -ge 256 ] 2>/dev/null; then COLOR=1
       elif [ "${ncolors:-0}" -ge 8 ] 2>/dev/null; then COLOR=1; fi ;;
  esac
fi
case "${LC_ALL:-}${LC_CTYPE:-}${LANG:-}" in
  *UTF-8*|*UTF8*|*utf-8*|*utf8*) [ "$FORCE_PLAIN" -eq 0 ] && UNICODE=1 ;;
esac
[ "$IS_TTY" -eq 1 ] || FAST=1   # never pace when output isn't a live terminal

# ──────────────────────────────────────────────────────────────────────────────
# Palette
# ──────────────────────────────────────────────────────────────────────────────
RESET=""; BOLD=""; DIM=""; PURPLE=""; GREEN=""; TEAL=""; RED=""; YELLOW=""
GRAD=()
if [ "$COLOR" -eq 1 ]; then
  RESET=$'\033[0m'; BOLD=$'\033[1m'; DIM=$'\033[2m'
  if [ "$TRUECOLOR" -eq 1 ]; then
    PURPLE=$'\033[38;2;153;69;255m'
    GREEN=$'\033[38;2;20;241;149m'
    TEAL=$'\033[38;2;0;209;255m'
    RED=$'\033[38;2;255;99;110m'
    YELLOW=$'\033[38;2;255;199;89m'
    # 6-stop purple→green ramp for the wordmark
    r0=153; g0=69; b0=255; r1=20; g1=241; b1=149
    i=0
    while [ "$i" -lt 6 ]; do
      r=$(( r0 + (r1 - r0) * i / 5 ))
      g=$(( g0 + (g1 - g0) * i / 5 ))
      b=$(( b0 + (b1 - b0) * i / 5 ))
      GRAD+=( $'\033[38;2;'"${r};${g};${b}"'m' )
      i=$(( i + 1 ))
    done
  else
    PURPLE=$'\033[35m'; GREEN=$'\033[32m'; TEAL=$'\033[36m'; RED=$'\033[31m'; YELLOW=$'\033[33m'
    if [ "${ncolors:-0}" -ge 256 ] 2>/dev/null; then
      GRAD=( $'\033[38;5;135m' $'\033[38;5;99m' $'\033[38;5;63m' $'\033[38;5;44m' $'\033[38;5;48m' $'\033[38;5;47m' )
    else
      GRAD=( "$PURPLE" "$PURPLE" "$TEAL" "$TEAL" "$GREEN" "$GREEN" )
    fi
  fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# Glyphs
# ──────────────────────────────────────────────────────────────────────────────
if [ "$UNICODE" -eq 1 ]; then
  G_OK="✓"; G_DOT="◆"; G_BAR="▌"; G_ARR="›"; G_RING="◎"; G_WARN="▲"
  BX_TL="╭"; BX_TR="╮"; BX_BL="╰"; BX_BR="╯"; BX_H="─"; BX_V="│"
  SEP="·"; DASH="—"
  SPIN=( "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏" )
else
  G_OK="OK"; G_DOT="*"; G_BAR="|"; G_ARR=">"; G_RING="(o)"; G_WARN="!"
  BX_TL="+"; BX_TR="+"; BX_BL="+"; BX_BR="+"; BX_H="-"; BX_V="|"
  SEP="-"; DASH="-"
  SPIN=( "|" "/" "-" "\\" )
fi

# Box / layout width
COLS="$(tput cols 2>/dev/null || echo 80)"
case "$COLS" in ''|*[!0-9]*) COLS=80 ;; esac
WIDTH=64
[ "$COLS" -lt 66 ] && WIDTH=$(( COLS - 2 ))
[ "$WIDTH" -lt 40 ] && WIDTH=40

# ──────────────────────────────────────────────────────────────────────────────
# Drawing helpers
# ──────────────────────────────────────────────────────────────────────────────
hide_cursor() { [ "$IS_TTY" -eq 1 ] && printf '\033[?25l'; return 0; }
show_cursor() { [ "$IS_TTY" -eq 1 ] && printf '\033[?25h'; return 0; }

repeat() { # $1 char  $2 count
  local out="" i=0
  while [ "$i" -lt "$2" ]; do out="$out$1"; i=$(( i + 1 )); done
  printf '%s' "$out"
}

gradient_line() { # $1 width — prints exactly N box-chars swept across the purple→green ramp
  local w="$1" i=0 col
  if [ "$COLOR" -eq 0 ] || [ "${#GRAD[@]}" -lt 2 ]; then repeat "$BX_H" "$w"; return; fi
  while [ "$i" -lt "$w" ]; do
    col=$(( i * 6 / w )); [ "$col" -gt 5 ] && col=5
    printf '%s%s' "${GRAD[$col]}" "$BX_H"
    i=$(( i + 1 ))
  done
  printf '%s' "$RESET"
}

pace() { # gentle, terminal-only cadence — instant in CI / pipes / --fast
  if [ "$FAST" -eq 0 ]; then sleep "${1:-0.30}"; fi
  return 0
}

reveal() { # print a line, then a brief beat
  printf '%s\n' "$1"; pace "${2:-0.06}"
}

section() { # $1 title
  printf '\n%s%s%s %s%s%s\n' "$PURPLE" "$G_BAR" "$RESET" "$BOLD" "$1" "$RESET"
  printf '%s%s%s\n' "$DIM" "$(repeat "$BX_H" "$WIDTH")" "$RESET"
  pace 0.08
}

kv() { # aligned key/value briefing row
  printf '  %s%s%s %s%-11s%s %s\n' "$PURPLE" "$G_DOT" "$RESET" "$DIM" "$1" "$RESET" "$2"
  pace 0.05
}

# Animated step. begin_step "msg"; <do work>; end_step ok|skip|warn "msg" "detail"
begin_step() {
  local msg="$1"
  if [ "$IS_TTY" -eq 1 ]; then
    hide_cursor
    (
      i=0; n=${#SPIN[@]}
      while :; do
        printf '\r  %s%s%s %s' "$TEAL" "${SPIN[$i]}" "$RESET" "$msg"
        i=$(( (i + 1) % n ))
        sleep 0.08
      done
    ) &
    spin_pid=$!
  fi
}
end_step() { # $1 status  $2 msg  $3 detail
  if [ -n "$spin_pid" ]; then
    kill "$spin_pid" >/dev/null 2>&1 || true
    wait "$spin_pid" 2>/dev/null || true
    spin_pid=""
  fi
  local mark color
  case "$1" in
    ok)   mark="$G_OK";   color="$GREEN" ;;
    skip) mark="$G_ARR";  color="$DIM" ;;
    warn) mark="$G_WARN"; color="$YELLOW" ;;
    *)    mark="$G_OK";   color="$GREEN" ;;
  esac
  local detail=""
  [ -n "${3:-}" ] && detail="  ${DIM}${3}${RESET}"
  if [ "$IS_TTY" -eq 1 ]; then printf '\r\033[K'; fi
  printf '  %s%s%s %s%s\n' "$color" "$mark" "$RESET" "$2" "$detail"
  show_cursor
  pace 0.16
}

count_glob() { # count existing paths among args (nullglob-safe)
  local n=0 f
  for f in "$@"; do [ -e "$f" ] && n=$(( n + 1 )); done
  printf '%d' "$n"
}

cleanup() {
  if [ -n "${spin_pid:-}" ]; then kill "$spin_pid" >/dev/null 2>&1 || true; fi
  show_cursor
  [ -n "${CLEANUP:-}" ] && rm -rf "$CLEANUP"
  return 0
}
trap cleanup EXIT
trap 'printf "\n"; exit 130' INT TERM

# ──────────────────────────────────────────────────────────────────────────────
# Resolve source — run-from-clone if next to skill/, else clone to a temp dir.
# ──────────────────────────────────────────────────────────────────────────────
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || echo "")"
if [ -z "$SRC_DIR" ] || [ ! -d "$SRC_DIR/skill" ]; then
  command -v git >/dev/null 2>&1 || { printf '%sgit is required to fetch %s%s\n' "$RED" "$REPO_URL" "$RESET" >&2; exit 1; }
  SRC_DIR="$(mktemp -d)"; CLEANUP="$SRC_DIR"
  begin_step "Fetching the brain from $REPO_URL"
  if git clone --depth 1 "$REPO_URL" "$SRC_DIR" >/dev/null 2>&1; then
    end_step ok "Fetched solana-brain source"
  else
    end_step warn "Clone failed"
    printf '%sCould not clone %s%s\n' "$RED" "$REPO_URL" "$RESET" >&2; exit 1
  fi
fi

VERSION_STR="$(cat "$SRC_DIR/VERSION" 2>/dev/null || echo "0.2.0")"
TODAY="$(date +%F 2>/dev/null || echo "2026-06")"

# Resolve target
if [ "$SCOPE" = "user" ]; then
  CLAUDE_DIR="${CLAUDE_HOME:-$HOME/.claude}"
  SCOPE_HINT="~/.claude ${SEP} every project"
else
  CLAUDE_DIR="$TARGET/.claude"
  SCOPE_HINT="./.claude ${SEP} this repo"
fi
SKILL_DEST="$CLAUDE_DIR/skills/$SKILL_NAME"
MEMORY_DIR="$TARGET/.solana-brain"   # institutional memory (project scope only)
REINSTALL=0; [ -d "$SKILL_DEST" ] && REINSTALL=1

# Host hint (best-effort, cosmetic)
HOST="Claude Code ${SEP} Codex ${SEP} Cursor"
if [ -n "${CLAUDECODE:-}" ]; then HOST="Claude Code (detected)"
elif [ "${TERM_PROGRAM:-}" = "vscode" ] && [ -n "${CURSOR_TRACE_ID:-}" ]; then HOST="Cursor (detected)"
fi

TERM_DESC="basic"
[ "$COLOR" -eq 1 ] && TERM_DESC="color"
[ "$TRUECOLOR" -eq 1 ] && TERM_DESC="truecolor"
[ "$UNICODE" -eq 1 ] && TERM_DESC="$TERM_DESC ${SEP} unicode"
[ "$COLOR" -eq 0 ] && TERM_DESC="plain"

# ──────────────────────────────────────────────────────────────────────────────
# 1 · Introductions
# ──────────────────────────────────────────────────────────────────────────────
printf '\n'
if [ "$UNICODE" -eq 1 ]; then
  b=(
    " ███████╗ ██████╗ ██╗      █████╗ ███╗   ██╗ █████╗ "
    " ██╔════╝██╔═══██╗██║     ██╔══██╗████╗  ██║██╔══██╗"
    " ███████╗██║   ██║██║     ███████║██╔██╗ ██║███████║"
    " ╚════██║██║   ██║██║     ██╔══██║██║╚██╗██║██╔══██║"
    " ███████║╚██████╔╝███████╗██║  ██║██║ ╚████║██║  ██║"
    " ╚══════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝"
  )
  i=0
  while [ "$i" -lt "${#b[@]}" ]; do
    if [ "$COLOR" -eq 1 ]; then
      printf '%s%s%s\n' "${GRAD[$i]:-$PURPLE}" "${b[$i]}" "$RESET"
    else
      printf '%s\n' "${b[$i]}"
    fi
    pace 0.05
    i=$(( i + 1 ))
  done
  printf '  %s%s%s %sbrain%s   %sthe chief-of-staff for an entire Solana company%s\n' \
    "$GREEN" "$G_RING" "$RESET" "$BOLD" "$RESET" "$DIM" "$RESET"
else
  printf '%s%s solana-brain %s\n' "$BOLD" "$G_RING" "$RESET"
  printf '%sthe chief-of-staff for an entire Solana company%s\n' "$DIM" "$RESET"
fi
printf '  '; gradient_line $(( WIDTH - 2 )); printf '\n'
pace 0.18

if [ "$REINSTALL" -eq 1 ]; then
  reveal "$(printf '\n  %sWelcome back.%s Re-briefing your brain to %sv%s%s.' "$BOLD" "$RESET" "$GREEN" "$VERSION_STR" "$RESET")" 0.10
else
  reveal "$(printf "\n  %sYour new chief-of-staff is reporting for duty%s ${DASH} %sv%s%s." "$BOLD" "$RESET" "$GREEN" "$VERSION_STR" "$RESET")" 0.10
  reveal "$(printf "  %sIt knows the whole job ${DASH} build ${SEP} ship ${SEP} secure ${SEP} grow ${SEP} operate ${DASH} and remembers every call.%s" "$DIM" "$RESET")" 0.10
fi

# ──────────────────────────────────────────────────────────────────────────────
# 2 · Briefing
# ──────────────────────────────────────────────────────────────────────────────
section "BRIEFING"
kv "Role"     "Recall → classify → route → orchestrate → verify → record"
kv "Scope"    "$SCOPE ${DIM}(${SCOPE_HINT})${RESET}"
kv "Office"   "$CLAUDE_DIR"
kv "Hosts"    "$HOST"
kv "Terminal" "$TERM_DESC"
kv "Posture"  "${GREEN}read-only${RESET} ${SEP} ${GREEN}key-safe${RESET} ${DIM}(your wallet signs ${DASH} never a private key)${RESET}"

# Overwrite consent (interactive only; non-interactive refreshes in place)
if [ "$REINSTALL" -eq 1 ]; then
  if [ "$ASSUME_YES" -eq 0 ] && [ "$INTERACTIVE" -eq 1 ]; then
    printf '\n  %s%s%s An install already exists at %s%s%s.\n' "$YELLOW" "$G_WARN" "$RESET" "$BOLD" "$SKILL_DEST" "$RESET"
    printf '  Re-onboard and refresh it? [Y/n] '
    read -r ans || true
    case "$ans" in [nN]*) printf '  %sStood down. Nothing changed.%s\n' "$DIM" "$RESET"; exit 0 ;; esac
  fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# 3 · Provisioning the office
# ──────────────────────────────────────────────────────────────────────────────
section "PROVISIONING"

begin_step "Preparing the office at $CLAUDE_DIR"
mkdir -p "$SKILL_DEST" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/commands"
end_step ok "Workspace ready" "$CLAUDE_DIR"

begin_step "Installing the brain ${DASH} router, clusters & references"
rm -rf "$SKILL_DEST"
mkdir -p "$SKILL_DEST"
cp -R "$SRC_DIR/skill/." "$SKILL_DEST/"
cp -R "$SRC_DIR/rules" "$SKILL_DEST/rules"
cp "$SRC_DIR/CLAUDE.md" "$SKILL_DEST/CLAUDE.md"
n_clusters="$(count_glob "$SRC_DIR"/skill/clusters/*.md)"
end_step ok "Brain installed" "5 clusters ${SEP} ${n_clusters} playbooks ${SEP} resolver"

begin_step "Onboarding the executive team"
cp -f "$SRC_DIR/agents/"*.md "$CLAUDE_DIR/agents/" 2>/dev/null || true
n_agents="$(count_glob "$SRC_DIR"/agents/*.md)"
end_step ok "Executive team onboarded" "${n_agents} agents"

begin_step "Wiring the command console"
cp -f "$SRC_DIR/commands/"*.md "$CLAUDE_DIR/commands/" 2>/dev/null || true
n_cmds="$(count_glob "$SRC_DIR"/commands/*.md)"
end_step ok "Command console wired" "${n_cmds} commands"

# Roster
printf '\n  %sYour executive team reports for duty:%s\n' "$DIM" "$RESET"
roster() { printf '   %s%s%s %s%-15s%s %s%s%s\n' "$PURPLE" "$G_DOT" "$RESET" "$BOLD" "$1" "$RESET" "$DIM" "$2" "$RESET"; pace 0.05; }
roster "chief-of-staff" "orchestrates every cross-functional play, holds the plan"
roster "build-lead"     "programs (Anchor/Pinocchio) + client apps"
roster "ship-lead"      "infra, RPC, deploy, CI/CD, reliability"
roster "secure-lead"    "audits, tx-safety, custody, incident response"
roster "grow-lead"      "GTM, token launch, community, fundraising"
roster "operate-lead"   "legal, tax, treasury, entity, hiring"

# ──────────────────────────────────────────────────────────────────────────────
# 4 · Wiring into the org chart (brain-first protocol)
# ──────────────────────────────────────────────────────────────────────────────
section "ORG CHART"

PROTOCOL_STATE="skip"
inject_protocol() {
  local md="$1"
  local marker="<!-- solana-brain:brain-first -->"
  if grep -qF "$marker" "$md" 2>/dev/null; then PROTOCOL_STATE="present"; return 0; fi
  {
    echo ""
    echo "$marker"
    echo "## solana-brain — brain-first protocol"
    echo "Before improvising on any Solana task, route through the brain: **recall** memory in"
    echo "\`.solana-brain/MEMORY.md\` → **classify** with \`.claude/skills/$SKILL_NAME/RESOLVER.md\` →"
    echo "open the matching cluster in \`.claude/skills/$SKILL_NAME/clusters/\` → **delegate** depth to the"
    echo "specialist skill it names → **respect gates** (SECURE before ship/launch; OPERATE legal/tax before"
    echo "a token) → **verify** → **record** the decision back to \`.solana-brain/\`. Memory is key-safe. See"
    echo "\`.claude/skills/$SKILL_NAME/SKILL.md\` and \`.claude/skills/$SKILL_NAME/references/memory.md\`."
    echo "<!-- /solana-brain:brain-first -->"
  } >> "$md"
  PROTOCOL_STATE="appended"
  return 0
}

if [ "$SCOPE" = "project" ]; then
  begin_step "Teaching the repo to think brain-first"
  touch "$TARGET/CLAUDE.md"
  inject_protocol "$TARGET/CLAUDE.md"
  case "$PROTOCOL_STATE" in
    appended) end_step ok   "Brain-first protocol added" "→ $(basename "$TARGET")/CLAUDE.md" ;;
    present)  end_step skip "Brain-first protocol already present" "CLAUDE.md unchanged" ;;
  esac
else
  begin_step "User-scope install"
  end_step skip "Brain-first protocol skipped" "add it per-repo to enforce routing"
fi

# ──────────────────────────────────────────────────────────────────────────────
# 5 · Institutional memory (project scope — the brain's long-term recall)
# ──────────────────────────────────────────────────────────────────────────────
MEMORY_STATE="skip"
seed_memory() {
  local tpl="$SRC_DIR/skill/memory-template" rel src dst seeded=0
  if [ ! -d "$tpl" ]; then MEMORY_STATE="notpl"; return 0; fi
  # Never touch an existing .solana-brain/ — if anything is there, it's the company's brain. Leave it.
  if [ -e "$MEMORY_DIR" ]; then MEMORY_STATE="present"; return 0; fi
  mkdir -p "$MEMORY_DIR/decisions"
  # Copy each template file only if absent; stamp the install date into the <date> placeholders.
  for rel in "MEMORY.md" "profile.md" "decisions/0000-template.md"; do
    src="$tpl/$rel"; dst="$MEMORY_DIR/$rel"
    [ -f "$src" ] || continue
    [ -e "$dst" ] && continue
    if sed "s/<date>/$TODAY/g" "$src" > "$dst.tmp" 2>/dev/null && mv "$dst.tmp" "$dst"; then
      seeded=1
    else
      rm -f "$dst.tmp" 2>/dev/null || true
      cp "$src" "$dst" 2>/dev/null || true     # fall back to an unstamped copy
      [ -e "$dst" ] && seeded=1
    fi
  done
  if [ "$seeded" -eq 1 ]; then MEMORY_STATE="seeded"; else MEMORY_STATE="notpl"; fi
  return 0
}

if [ "$SCOPE" = "project" ]; then
  section "MEMORY"
  begin_step "Initializing institutional memory"
  seed_memory
  case "$MEMORY_STATE" in
    seeded)  end_step ok   "Institutional memory online" "$MEMORY_DIR" ;;
    present) end_step skip "Memory preserved" "existing .solana-brain kept untouched" ;;
    notpl)   end_step warn "Memory template missing" "skipped" ;;
  esac
  printf "  %s%s%s %severy decision recalled before & recorded after ${DASH} key-safe, never a private key%s\n" \
    "$PURPLE" "$G_DOT" "$RESET" "$DIM" "$RESET"
fi

# ──────────────────────────────────────────────────────────────────────────────
# 6 · First-day verification
# ──────────────────────────────────────────────────────────────────────────────
section "VERIFICATION"

VERIFY_OK=1
check() { # $1 label  $2 path-or-test (file existence)
  begin_step "Verifying $1"
  if [ -e "$2" ]; then end_step ok "$1"; else end_step warn "$1 missing"; VERIFY_OK=0; fi
}
check "router (SKILL.md)"      "$SKILL_DEST/SKILL.md"
check "resolver (RESOLVER.md)" "$SKILL_DEST/RESOLVER.md"
check "clusters"               "$SKILL_DEST/clusters"
check "agents"                 "$CLAUDE_DIR/agents/chief-of-staff.md"
check "commands"               "$CLAUDE_DIR/commands/brain.md"
check "memory protocol"        "$SKILL_DEST/references/memory.md"
if [ "$SCOPE" = "project" ]; then check "memory store (.solana-brain)" "$MEMORY_DIR/MEMORY.md"; fi

# ──────────────────────────────────────────────────────────────────────────────
# 7 · Briefing complete — summary
# ──────────────────────────────────────────────────────────────────────────────
title=" solana-brain v$VERSION_STR  -  onboarded "
inner=$(( WIDTH - 2 ))
printf '\n'
printf '%s%s%s%s%s\n' "$PURPLE" "$BX_TL" "$(repeat "$BX_H" "$inner")" "$BX_TR" "$RESET"
pad=$(( inner - ${#title} ))
[ "$pad" -lt 0 ] && pad=0
printf '%s%s%s%s%s%s%s%s%s\n' "$PURPLE" "$BX_V" "$RESET" "$BOLD$GREEN" "$title" "$RESET" "$(repeat ' ' "$pad")" "$PURPLE$BX_V" "$RESET"
printf '%s%s%s%s%s\n' "$PURPLE" "$BX_BL" "$(repeat "$BX_H" "$inner")" "$BX_BR" "$RESET"

printf '\n  %sWhere everything lives%s\n' "$BOLD" "$RESET"
printf '   %s%s%s skill     %s%s%s\n' "$GREEN" "$G_DOT" "$RESET" "$DIM" "$SKILL_DEST" "$RESET"
printf '   %s%s%s agents    %s%s/agents/%s\n' "$GREEN" "$G_DOT" "$RESET" "$DIM" "$CLAUDE_DIR" "$RESET"
printf '   %s%s%s commands  %s%s/commands/%s\n' "$GREEN" "$G_DOT" "$RESET" "$DIM" "$CLAUDE_DIR" "$RESET"
if [ "$SCOPE" = "project" ]; then
  printf '   %s%s%s memory    %s%s%s\n' "$GREEN" "$G_DOT" "$RESET" "$DIM" "$MEMORY_DIR" "$RESET"
fi

printf "\n  %sFirst moves%s %s${DASH} say one in Claude Code%s\n" "$BOLD" "$RESET" "$DIM" "$RESET"
printf '   %s%s%s %s/brain%s        we want to launch a token next month\n' "$TEAL" "$G_ARR" "$RESET" "$PURPLE" "$RESET"
printf '   %s%s%s %s/ship-it%s      the vault program\n' "$TEAL" "$G_ARR" "$RESET" "$PURPLE" "$RESET"
printf '   %s%s%s %s/launch-token%s governance token, US + India users\n' "$TEAL" "$G_ARR" "$RESET" "$PURPLE" "$RESET"
printf '   %s%s%s %s/incident%s     our claim endpoint is draining wallets\n' "$TEAL" "$G_ARR" "$RESET" "$PURPLE" "$RESET"
printf '   %s%s%s %s/recall%s       where were we — what have we already decided\n' "$TEAL" "$G_ARR" "$RESET" "$PURPLE" "$RESET"

printf "\n  %sGet it anywhere%s  %scurl | bash ${SEP} npx solana-brain ${SEP} brew install solana-brain%s\n" \
  "$BOLD" "$RESET" "$DIM" "$RESET"
printf "  %s%s read-only ${SEP} key-safe%s  %sthe brain plans, routes & verifies ${DASH} your wallet signs.%s\n" \
  "$GREEN" "$G_OK" "$RESET" "$DIM" "$RESET"

if [ "$VERIFY_OK" -eq 1 ]; then
  printf '  %s%s briefing complete%s  %sthe brain is on the job.%s\n\n' "$GREEN" "$G_OK" "$RESET" "$DIM" "$RESET"
else
  printf "  %s%s onboarded with warnings%s  %ssome files did not verify ${DASH} re-run from a clean clone.%s\n\n" \
    "$YELLOW" "$G_WARN" "$RESET" "$DIM" "$RESET"
fi
