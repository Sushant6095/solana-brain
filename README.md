# 🧠 solana-brain

**The brain for building and operating an entire Solana company.** One installable skill you drop
into any Solana repo with a single command. It's not another vertical skill — it's an **intelligent
router** that classifies any request, sends it to the right one of five clusters, sequences
cross-functional work with gates, and **delegates depth to the best existing skills**.

> *"I know how to build and operate an entire Solana company."*

> **Read-only / key-safe.** solana-brain plans, builds, simulates, and reviews. It never asks for or
> uses a private key or seed phrase, and never auto-signs or moves funds. Your wallet signs.

## What it is (and what it isn't)

- **It is** a chief-of-staff: recall → classify → route → orchestrate → verify → record. The value is
  knowing *what to do next* across the whole company, *not skipping gates*, and *remembering every
  decision* so it's never re-litigated.
- **It isn't** a re-implementation of the ecosystem, and it isn't a dev-config kit. It **routes to**
  specialists (sendai, Helius, Jupiter, Metaplex, Trail of Bits, `crypto-legal`, `solana-accounting`,
  `solana-client-layer`) instead of duplicating them — so it stays small and current.

## The five clusters

| | Cluster | Owns |
|---|---|---|
| 🛠 | **BUILD** | Programs (Anchor/Pinocchio) + client apps (tx landing, safety, Actions/Blinks, streaming, frontends) |
| 🚀 | **SHIP** | Infra, RPC, deploy, CI/CD, observability, reliability, on-call |
| 🛡 | **SECURE** | Program audits, client/user tx-safety, key/treasury custody, supply chain, incident response *(the cross-cutting gate)* |
| 📈 | **GROW** | GTM, token launch, community, fundraising, hackathons |
| 🏛 | **OPERATE** | Legal/compliance, tax/accounting, treasury, entity, hiring *(informational — flags counsel/CPA)* |

The brain's edge is **orchestration**: a token launch isn't "GROW," it's `BUILD → SECURE → OPERATE → GROW`
with a gate between each. Skipping the SECURE or OPERATE gate is the classic, expensive mistake — the
brain won't let it happen silently.

## Install (one command)

```bash
# Into the current repo (recommended) — drops the skill into ./.claude and adds a brain-first protocol to CLAUDE.md
curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash

# User-wide (all your projects)
curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash -s -- --user
```

Other paths:

```bash
# npm — run without installing, or install the command globally
npx solana-brain                       # onboard into the current repo
npx solana-brain --user                # onboard user-wide (~/.claude)
npm install -g solana-brain            # then: solana-brain   (any flag works)

# Homebrew (via a tap)
brew install Sushant6095/tap/solana-brain && solana-brain
brew install --HEAD Sushant6095/tap/solana-brain   # bleeding edge from main

# Let your agent do it (Claude Code / Codex / Cursor)
#   point it at: https://raw.githubusercontent.com/Sushant6095/solana-brain/main/INSTALL_FOR_AGENTS.md
```

Every channel runs the same installer — a paced, branded onboarding (Solana-gradient banner, live
verification, your executive team reporting for duty) that degrades cleanly over `curl | bash`,
`NO_COLOR`, and non-UTF-8 terminals. Flags: `--user`, `--project DIR`, `-y`, `--fast`, `--plain`.

No build step, no runtime deps (npm path needs Node ≥16 + bash). Supply your own RPC/provider keys by
env var — the brain never bundles or requests keys.

## Use it

Just talk to the brain — it figures out the cluster(s):

```
/brain we want to launch a token next month
/company-setup my-solana-startup
/ship-it the vault program
/launch-token governance token, US + India users
/raise hackathon: Colosseum
/incident our claim endpoint is draining wallets
/recall where were we — what have we already decided
/remember chose Cayman foundation + DE C-corp for the token entity, per counsel
```

…or describe a goal in plain language and the `chief-of-staff` returns a gated, multi-cluster plan.
It **recalls** the project's memory before routing and **records** every decision after verifying.

## 🧠 Institutional memory

A chief-of-staff who forgets last week is useless. solana-brain keeps **per-project memory** so every
prompt, decision, and gate is remembered across sessions — and never re-litigated.

- **Recall before routing, record after verifying.** The brain loop becomes
  `recall → classify → route → orchestrate → verify → record`.
- **Lives at `.solana-brain/`** in your repo (git-trackable, tool-agnostic — not buried in `.claude/`):
  a skimmable `MEMORY.md` snapshot, durable `profile.md` facts, and ADR-style `decisions/`.
- **No slop.** Entries are factual, dated, and specific; decisions are superseded, never silently
  overwritten — the installer **never** wipes an existing `.solana-brain/`.
- **Key-safe.** Public keys, program IDs, decisions, and rationale only — never a private key or seed.

Surface it with [`/recall`](commands/recall.md); write it with [`/remember`](commands/remember.md).
Full protocol: [`skill/references/memory.md`](skill/references/memory.md).

## Structure

```
solana-brain/
├── skill/
│   ├── SKILL.md                 # the brain: recall → classify → route → orchestrate → verify → record
│   ├── RESOLVER.md              # intent → cluster routing table
│   ├── clusters/                # build · ship · secure · grow · operate
│   ├── references/              # orchestration · ecosystem-map · company-lifecycle · memory · accuracy-and-safety · changelog-pinning
│   └── memory-template/         # seed for a project's .solana-brain/ (MEMORY.md · profile.md · decisions/)
├── agents/                      # chief-of-staff (orchestrator) + 5 cluster leads
├── commands/                    # /brain /company-setup /ship-it /launch-token /raise /incident /recall /remember
├── rules/                       # brain-first · safety-and-keys
├── bin/solana-brain.mjs         # npm entry point (runs install.sh; cross-platform)
├── install.sh                   # premium installer (curl|bash, npx, brew, run-from-clone)
├── INSTALL_FOR_AGENTS.md        # agent-driven install flow
├── solana-brain.rb              # Homebrew formula
├── package.json                 # npm metadata + bin
├── CLAUDE.md / AGENTS.md        # agent entry points + brain-first protocol
├── llms.txt                     # machine-readable doc map
└── LICENSE                      # MIT
```

Progressive, token-efficient: `SKILL.md` routes; clusters and references load only when needed.
Per-project memory is written to `.solana-brain/` at your repo root, separate from the read-only skill.

## How it relates to the Solana AI Kit

Complementary, not overlapping. The kit is a full dev-config aggregator (agents/commands/rules +
ecosystem submodules) for *building*. solana-brain is a single installable **operator's brain** for
the *whole company lifecycle* — it routes across build **and** ship/secure/grow/operate, installs
into any repo with one command, injects a brain-first protocol, and orchestrates gated
cross-functional workflows. It delegates to the kit's skills rather than replacing them.

## Versioning

Router/orchestration logic is semver (`0.2.0` — adds institutional memory + npm/brew install); fast-moving
facts the clusters reference are calendar-pinned `2026-06`. See [`skill/references/changelog-pinning.md`](skill/references/changelog-pinning.md).

## Contributing

Add clusters/playbooks, expand the ecosystem map, or wire new specialist skills. Keep the brain a
**router** — push depth into specialist skills, not into the brain. Read-only / key-safe; cite
primary docs for time-sensitive specifics.

## License

MIT — see [LICENSE](LICENSE).
