# Adding `solana-brain` to the Solana AI Kit

A drop-in guide for [**solanabr/solana-ai-kit**](https://github.com/solanabr/solana-ai-kit) maintainers.

solana-brain follows the kit's exact skill convention — a `skill/SKILL.md` entry point, optional
`agents/` · `commands/` · `rules/`, an installer, and an MIT license — so it slots in the **same way**
`solana-game`, `solana-dev`, and the other `.claude/skills/ext/*` skills already do. No special-casing.

> **Why merge it, not just list it:** the kit gives builders the *skills*; solana-brain gives them the
> *move*. It **routes to** the kit's existing `ext/` skills (it never duplicates them), so once added it
> becomes the kit's **orchestration + memory front-door** across build · ship · secure · grow · operate.

---

## TL;DR — one command

```bash
git submodule add https://github.com/Sushant6095/solana-brain.git .claude/skills/ext/solana-brain
```

Commit, and the kit's `install.sh` / `update.sh` initialize it alongside the other `ext/` skills.

---

## Step 1 — add it as a submodule (identical to the other `ext/` skills)

```bash
cd solana-ai-kit
git submodule add https://github.com/Sushant6095/solana-brain.git .claude/skills/ext/solana-brain
git submodule update --init --recursive .claude/skills/ext/solana-brain
```

This appends to `.gitmodules` — matching the existing entries exactly:

```ini
[submodule ".claude/skills/ext/solana-brain"]
	path = .claude/skills/ext/solana-brain
	url = https://github.com/Sushant6095/solana-brain.git
```

The entry point resolves at `.claude/skills/ext/solana-brain/skill/SKILL.md` — the **same `skill/SKILL.md`
layout** as `solana-game-skill`, so skill discovery treats it identically. Pin to a tag if you prefer
reproducibility (`v0.2.0` is released):

```bash
cd .claude/skills/ext/solana-brain && git checkout v0.2.0 && cd -
```

---

## Step 2 — (optional) catalog it in `skill-registry.json`

Add this object to the `entries` array in [`.claude/skills/skill-registry.json`](https://github.com/solanabr/solana-ai-kit/blob/main/.claude/skills/skill-registry.json):

```json
{
  "id": "solana-brain",
  "name": "Solana Brain",
  "type": "skill",
  "domain": "orchestration",
  "description": "Chief-of-staff router for an entire Solana company: classifies any request across five clusters (BUILD/SHIP/SECURE/GROW/OPERATE), sequences cross-functional work with non-negotiable gates, delegates depth to the kit's existing ext/ skills, and keeps per-project institutional memory so decisions are never re-litigated.",
  "source": "https://github.com/Sushant6095/solana-brain",
  "install": { "method": "submodule", "command": "git submodule add https://github.com/Sushant6095/solana-brain.git .claude/skills/ext/solana-brain", "env": [] },
  "license": "MIT",
  "maintainer": "Sushant6095",
  "signal": { "stars": 0, "last_commit": "2026-06-30", "reputability": "community" },
  "default_installed": true,
  "safety": "clean — zero runtime dependencies; read-only / key-safe (never requests private keys, never moves funds); installer only writes .claude/ + .solana-brain/ and appends a fenced block to CLAUDE.md; no curl|sh, no auto-running hooks",
  "tags": ["orchestration", "router", "chief-of-staff", "memory", "build", "ship", "secure", "grow", "operate", "token-launch"]
}
```

> Set `default_installed: true` to make the brain the kit's front-door router; `false` keeps it opt-in
> like the discovery catalog. Re-bucket `domain` if `orchestration` isn't in your taxonomy yet.

---

## Step 3 — commit & verify

```bash
git add .gitmodules .claude/skills/ext/solana-brain .claude/skills/skill-registry.json
git commit -m "feat(skills): add solana-brain (bounty) as ext/ submodule"

# users pick it up via the kit's normal flow:
./install.sh                                   # inits all ext/ submodules
# or, to refresh later:
./update.sh

# sanity check the entry point is present:
git submodule update --init --recursive
ls .claude/skills/ext/solana-brain/skill/SKILL.md
```

In any repo onboarded by the kit, `skill/SKILL.md` is discovered and the brain begins routing
(`recall → classify → route → orchestrate → verify → record`).

---

## How it composes with the kit (delegate, don't duplicate)

solana-brain adds the connective tissue the kit doesn't have — classification, cross-cluster
sequencing, gates, verification, and memory — and **delegates depth to the kit's own `ext/` skills**:

| Brain cluster | Routes to (already in the kit's `ext/`) |
|---|---|
| 🛠 **BUILD** | `solana-dev` · `sendai` · `jupiter` · `metaplex` · `quicknode-anchor` · `eth-to-sol` · `solana-mobile` · `solana-game` |
| 🚀 **SHIP** | `helius` · `cloudflare` · `vercel` |
| 🛡 **SECURE** | `trailofbits` · `qedgen` · `safe-solana-builder` · `ghostsecurity` · `defending-code` |
| 📈 **GROW** | `colosseum` · `solana-new` |
| 🏛 **OPERATE** | _(legal/tax verticals — a current gap; the brain carries baseline guidance and flags counsel/CPA)_ |

So merging it doesn't add overlap — it makes everything already in the kit **reachable in the right
order, with the right gate, with memory of what was already decided.**

---

## Updating the pin

Submodules pin a commit. To bump solana-brain later:

```bash
cd .claude/skills/ext/solana-brain && git pull origin main && cd -
git add .claude/skills/ext/solana-brain
git commit -m "chore(skills): bump solana-brain"
```

---

## License

**MIT** — compatible with either merge or submodule inclusion. See [LICENSE](LICENSE).
