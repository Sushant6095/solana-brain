# 🧠 solana-brain

**The brain for building and operating an entire Solana company.** One installable skill you drop
into any Solana repo with a single command. It's not another vertical skill — it's an **intelligent
router** that classifies any request, sends it to the right one of five clusters, sequences
cross-functional work with gates, and **delegates depth to the best existing skills**.

> *"I know how to build and operate an entire Solana company."*

> **Read-only / key-safe.** solana-brain plans, builds, simulates, and reviews. It never asks for or
> uses a private key or seed phrase, and never auto-signs or moves funds. Your wallet signs.

## What it is (and what it isn't)

- **It is** a chief-of-staff: intake → classify → route → orchestrate → verify. The value is
  knowing *what to do next* across the whole company and *not skipping gates*.
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
# bun / npx (from the repo)
bun install -g github:Sushant6095/solana-brain   # then: solana-brain   (or: solana-brain --user)
npx solana-brain                                 # installs into the current repo

# Homebrew (via a tap)
brew install Sushant6095/tap/solana-brain && solana-brain

# Let your agent do it (Claude Code / Codex / Cursor)
#   point it at: https://raw.githubusercontent.com/Sushant6095/solana-brain/main/INSTALL_FOR_AGENTS.md
```

No build step, no runtime deps. Supply your own RPC/provider keys by env var — the brain never
bundles or requests keys.

## Use it

Just talk to the brain — it figures out the cluster(s):

```
/brain we want to launch a token next month
/company-setup my-solana-startup
/ship-it the vault program
/launch-token governance token, US + India users
/raise hackathon: Colosseum
/incident our claim endpoint is draining wallets
```

…or describe a goal in plain language and the `chief-of-staff` returns a gated, multi-cluster plan.

## Structure

```
solana-brain/
├── skill/
│   ├── SKILL.md                 # the brain: intake → classify → route → orchestrate → verify
│   ├── RESOLVER.md              # intent → cluster routing table
│   ├── clusters/                # build · ship · secure · grow · operate
│   └── references/              # orchestration · ecosystem-map · company-lifecycle · accuracy-and-safety · changelog-pinning
├── agents/                      # chief-of-staff (orchestrator) + 5 cluster leads
├── commands/                    # /brain /company-setup /ship-it /launch-token /raise /incident
├── rules/                       # brain-first · safety-and-keys
├── install.sh                   # one-command installer (curl|bash, npx/bun, run-from-clone)
├── INSTALL_FOR_AGENTS.md        # agent-driven install flow
├── solana-brain.rb              # Homebrew formula template
├── CLAUDE.md / AGENTS.md        # agent entry points + brain-first protocol
├── llms.txt                     # machine-readable doc map
└── LICENSE                      # MIT
```

Progressive, token-efficient: `SKILL.md` routes; clusters and references load only when needed.

## How it relates to the Solana AI Kit

Complementary, not overlapping. The kit is a full dev-config aggregator (agents/commands/rules +
ecosystem submodules) for *building*. solana-brain is a single installable **operator's brain** for
the *whole company lifecycle* — it routes across build **and** ship/secure/grow/operate, installs
into any repo with one command, injects a brain-first protocol, and orchestrates gated
cross-functional workflows. It delegates to the kit's skills rather than replacing them.

## Versioning

Router/orchestration logic is semver (`0.1.0`); fast-moving facts the clusters reference are
calendar-pinned `2026-06`. See [`skill/references/changelog-pinning.md`](skill/references/changelog-pinning.md).

## Contributing

Add clusters/playbooks, expand the ecosystem map, or wire new specialist skills. Keep the brain a
**router** — push depth into specialist skills, not into the brain. Read-only / key-safe; cite
primary docs for time-sensitive specifics.

## License

MIT — see [LICENSE](LICENSE).
