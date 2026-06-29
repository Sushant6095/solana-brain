# Install solana-brain (instructions for an AI agent)

You are an AI coding agent (Claude Code, Codex, Cursor, …). The user wants you to install
**solana-brain** — a single skill that routes across five clusters (BUILD, SHIP, SECURE, GROW,
OPERATE) to build and operate a Solana company. Follow these steps, then verify.

> solana-brain is **read-only / key-safe**. Do not request, generate, or store any private key or
> seed phrase during install. No key is required.

## Steps

1. **Pick scope.** Ask the user: install into *this project* (`./.claude`, recommended) or
   *user-wide* (`~/.claude`, all projects)? Default to project.
2. **Run the installer** from the repo root. Any channel works:
   ```bash
   # curl | bash — project scope (run in the project root)
   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash
   # or user scope
   curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash -s -- --user
   # npm (no clone needed)
   npx solana-brain            # add --user for user scope
   # Homebrew
   brew install Sushant6095/tap/solana-brain && solana-brain
   ```
   If `curl|bash` is unavailable, `git clone https://github.com/Sushant6095/solana-brain` and run
   `./install.sh` (add `--user` for user scope). For non-interactive runs add `-y`.
3. **Confirm the layout** under the chosen `.claude/` (skill contents are flattened to the skill root —
   there is no `skill/` segment after install):
   - `skills/solana-brain/SKILL.md`, `RESOLVER.md`, `clusters/*.md`, `references/*.md` (incl. `references/memory.md`)
   - `skills/solana-brain/rules/*.md`
   - `agents/{chief-of-staff,build-lead,ship-lead,secure-lead,grow-lead,operate-lead}.md`
   - `commands/{brain,company-setup,ship-it,launch-token,raise,incident,recall,remember}.md`
   - **Memory (project scope):** `.solana-brain/{MEMORY.md,profile.md,decisions/}` at the repo root.
     The installer **never overwrites** an existing `.solana-brain/`.
4. **Brain-first protocol.** For a project install, confirm the installer appended the
   `<!-- solana-brain:brain-first -->` block to the project's `CLAUDE.md`. If missing, add it
   (see `skills/solana-brain/rules/brain-first.md`).
5. **Adopt the protocol now.** From here on, route Solana tasks through the brain: **recall**
   `.solana-brain/MEMORY.md` → classify with `RESOLVER.md` → open the matching cluster → delegate to
   the specialist skill it names → respect gates → verify → **record** the decision back to `.solana-brain/`.

## Verify (end-to-end)

- Run `/brain do a quick self-check` (or read `skill/SKILL.md`) and confirm the brain lists the five
  clusters and the routing table.
- Pick a sample goal ("launch a token next month") and confirm the brain returns a **gated,
  multi-cluster plan** (BUILD → SECURE → OPERATE → GROW), not a single-step answer.
- Run `/recall` and confirm it reads `.solana-brain/MEMORY.md`; make a decision and confirm `/remember`
  writes a record. Memory must store public data only.
- Confirm no private key was ever requested.

## Notes

- solana-brain **routes to** ecosystem skills (sendai, Helius, Jupiter, Metaplex, Trail of Bits,
  crypto-legal, solana-accounting, solana-client-layer) rather than duplicating them. If those
  aren't installed, the cluster files still give enough to act and flag the gap.
- License: MIT. Targets Claude Code / Codex / Cursor and any agent that reads markdown skills.
