<div align="center">

# 🧠 solana-brain

### The chief-of-staff for an entire Solana company.

**One skill you drop into _any_ repo — brand-new or mid-flight — that knows the whole job:
`build · ship · secure · grow · operate`.** It's not another vertical skill. It's an **intelligent
router** that classifies any request, sends it to the right one of five clusters, sequences
cross-functional work with non-negotiable gates, **delegates depth to the best existing ecosystem
skills**, and **remembers every decision** so it's never re-litigated.

<br/>

![version](https://img.shields.io/badge/version-0.2.0-9945FF?style=for-the-badge)
![license](https://img.shields.io/badge/license-MIT-14F195?style=for-the-badge)
![read-only](https://img.shields.io/badge/read--only-key--safe-1f2937?style=for-the-badge)
![stack](https://img.shields.io/badge/stack-current%202026--06-9945FF?style=for-the-badge)

![install](https://img.shields.io/badge/install-one%20command-14F195?style=flat-square)
![runtime](https://img.shields.io/badge/runtime-no%20build%20·%20no%20deps-1f2937?style=flat-square)
![agents](https://img.shields.io/badge/works%20with-Claude%20Code%20·%20Codex%20·%20Cursor-9945FF?style=flat-square)
![memory](https://img.shields.io/badge/institutional-memory-14F195?style=flat-square)

<br/>

> _"Search gives you skills. The brain gives you the **move**."_

</div>

> **Read-only / key-safe.** solana-brain plans, builds, simulates, routes, and reviews. It never asks
> for or uses a private key or seed phrase, and never auto-signs or moves funds. **Your wallet signs.**

---

## Contents

- [The problem](#the-problem)
- [⚡ Drop it into your repo — new project _or_ mid-flight](#-drop-it-into-your-repo--new-project-or-mid-flight)
- [Install](#install)
- [What lands in your repo](#what-lands-in-your-repo)
- [The five clusters](#the-five-clusters)
- [How the brain works](#how-the-brain-works-the-loop)
- [Orchestration — the real edge](#orchestration--the-real-edge)
- [Use it](#use-it)
- [🧠 Institutional memory](#-institutional-memory)
- [Routes to the ecosystem (doesn't reinvent it)](#routes-to-the-ecosystem-doesnt-reinvent-it)
- [Agents & commands](#agents--commands)
- [Where it fits in the Solana AI Kit](#where-it-fits-in-the-solana-ai-kit)
- [Repository structure](#repository-structure)
- [Safety model](#safety-model)
- [Versioning · Compatibility · Uninstall](#versioning--compatibility--uninstall)
- [Contributing · License](#contributing--license)

---

## The problem

Building on Solana isn't one job — it's five, and they're entangled. A token launch isn't a "growth"
task; it's a **program** you must **secure**, wrapped in an **entity** with **tax/securities**
exposure, then taken to market. The expensive mistakes aren't usually bad code — they're **skipped
gates** (shipping unaudited, launching before legal) and **re-litigated decisions** (re-deciding the
entity structure three sessions later because nobody wrote down why).

Skill catalogs and search help you find _a_ tool. They don't tell you **what to do next across the
whole company**, **in what order**, **with which gate**, **remembering what you already decided.**

That's the gap solana-brain fills. It's the connective tissue specialists don't provide:
**classification + sequencing + gates + verification + memory.**

---

## ⚡ Drop it into your repo — new project _or_ mid-flight

solana-brain installs **into the repo you're standing in.** No framework to adopt, no restructuring,
no lock-in. You run **one command at your project root** and it provisions a `.claude/` brain plus a
`.solana-brain/` memory store right there — and from then on every coding-agent session in that repo
**consults the brain first** before improvising.

| Your situation | What happens |
|---|---|
| 🌱 **Bootstrapping a brand-new project** | Run it in the fresh/empty repo. You get the full `BUILD → SHIP → SECURE → GROW → OPERATE` playbook, six executive agents, eight commands, and a clean institutional-memory store from line one. |
| 🛠 **Already deep in an existing codebase** | Run it at the root of your repo. It's **non-destructive** — never touches your source, never wipes an existing `.solana-brain/` — appends a brain-first protocol to your `CLAUDE.md`, and meets you exactly where you are. |
| 🔁 **Re-running later (upgrades)** | Idempotent. Re-running preserves your accumulated memory and decisions; it only refreshes the skill files. |

```bash
cd your-solana-repo     # new or existing — doesn't matter, it works at the root
curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash
# → .claude/ (brain · agents · commands) + .solana-brain/ (memory) provisioned at your repo root
```

That's the whole onboarding. Open your agent and say `/brain what should we do next` — or just describe
a goal in plain language.

---

## Install

**Zero-install, works today — into the current repo (recommended):**

```bash
curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash
```

**User-wide (all your projects, into `~/.claude`):**

```bash
curl -fsSL https://raw.githubusercontent.com/Sushant6095/solana-brain/main/install.sh | bash -s -- --user
```

**Other channels** — every one runs the same installer:

```bash
# npm — run without installing, or install the command globally
npx solana-brain                 # onboard into the current repo
npx solana-brain --user          # onboard user-wide (~/.claude)
npm install -g solana-brain      # then run:  solana-brain   (any flag works)

# Homebrew (via a tap)
brew install Sushant6095/tap/solana-brain && solana-brain
brew install --HEAD Sushant6095/tap/solana-brain   # bleeding edge from main

# Let your agent install it (Claude Code / Codex / Cursor)
#   point it at: https://raw.githubusercontent.com/Sushant6095/solana-brain/main/INSTALL_FOR_AGENTS.md
```

The installer is a paced, branded onboarding — Solana-gradient banner, live verification, your
executive team reporting for duty — that **degrades cleanly** over `curl | bash`, `NO_COLOR`, and
non-UTF-8 terminals. Flags: `--user`, `--project DIR`, `-y`, `--fast`, `--plain`.

> **No build step. No runtime dependencies** (the npm path needs Node ≥ 16 + bash). Supply your own
> RPC/provider keys by environment variable — the brain never bundles, requests, or stores keys.

---

## What lands in your repo

Running the installer at your repo root drops exactly this — and nothing else:

```text
your-solana-repo/
├── .claude/
│   ├── skills/solana-brain/      # the router: SKILL.md · RESOLVER.md · clusters/ · references/
│   ├── agents/                   # chief-of-staff + 5 cluster leads
│   └── commands/                 # /brain /company-setup /ship-it /launch-token /raise /incident /recall /remember
├── .solana-brain/                # your institutional memory (git-trackable, tool-agnostic)
│   ├── MEMORY.md                 #   snapshot + decisions index (recalled first, every session)
│   ├── profile.md                #   durable company facts
│   └── decisions/                #   one ADR-style record per consequential decision
└── CLAUDE.md                     # brain-first protocol appended (your code is untouched)
```

Your source code, build config, and existing files are **never modified** — only `CLAUDE.md` gets a
clearly-fenced protocol block appended. To remove it entirely: delete `.claude/skills/solana-brain/`
and `.solana-brain/`.

---

## The five clusters

| | Cluster | Owns |
|---|---|---|
| 🛠 | **BUILD** | Programs (Anchor/Pinocchio) + client apps — tx landing, safety, Actions/Blinks, streaming, frontends |
| 🚀 | **SHIP** | Infra, RPC, deploy, CI/CD, observability, reliability, on-call readiness |
| 🛡 | **SECURE** | Program audits, client/user tx-safety, key/treasury custody, supply chain, incident response — _the cross-cutting gate_ |
| 📈 | **GROW** | GTM, token launch, community, fundraising, hackathons, growth analytics |
| 🏛 | **OPERATE** | Legal/compliance, tax/accounting, treasury, entity formation, hiring — _informational; flags counsel/CPA_ |

---

## How the brain works (the loop)

```mermaid
flowchart LR
  R["🧠 recall<br/>.solana-brain"] --> C{"classify<br/>RESOLVER"}
  C -->|build| B["🛠 BUILD"]
  C -->|ship| S["🚀 SHIP"]
  C -->|secure| SE["🛡 SECURE"]
  C -->|grow| G["📈 GROW"]
  C -->|operate| O["🏛 OPERATE"]
  B --> V["✅ verify"]
  S --> V
  SE --> V
  G --> V
  O --> V
  V --> W["📝 record<br/>.solana-brain"]
  W -.->|next session| R
```

`recall → intake → classify → route → orchestrate → hand off → verify → record.` Progressive
disclosure means only the cluster file the request actually needs is ever loaded — the brain stays
small and token-efficient. Full loop in [`skill/SKILL.md`](skill/SKILL.md).

---

## Orchestration — the real edge

Single-cluster questions are easy. The brain earns its keep on **cross-functional goals**, where it
sequences clusters with **gates** and won't let a critical one get skipped silently:

```mermaid
flowchart LR
  subgraph launch ["/launch-token — gated, multi-cluster"]
    direction LR
    B["🛠 BUILD<br/>token program + mint"] --> g1{"🛡 SECURE gate<br/>audit · tx-safety"}
    g1 --> O["🏛 OPERATE<br/>entity · securities · tax"]
    O --> g2{"legal / CPA<br/>review flag"}
    g2 --> G["📈 GROW<br/>GTM · launchpad · community"]
  end
```

A token launch is **not** "GROW." It's `BUILD → SECURE → OPERATE → GROW`, with a gate between each.
Skipping the SECURE or OPERATE gate is the classic, expensive mistake — the brain surfaces it instead
of marching past it. Playbooks live in [`skill/references/orchestration.md`](skill/references/orchestration.md).

---

## Use it

Just talk to the brain — it figures out the cluster(s):

```text
/brain         we want to launch a token next month
/company-setup my-solana-startup
/ship-it       the vault program
/launch-token  governance token, US + India users
/raise         hackathon: Colosseum
/incident      our claim endpoint is draining wallets
/recall        where were we — what have we already decided
/remember      chose Cayman foundation + DE C-corp for the token entity, per counsel
```

…or describe a goal in plain language and the `chief-of-staff` returns a gated, multi-cluster plan.
It **recalls** the project's memory before routing and **records** every decision after verifying.

---

## 🧠 Institutional memory

A chief-of-staff who forgets last week is useless. solana-brain keeps **per-project memory** so every
decision and gate survives across sessions — and is **never re-litigated**.

- **Recall before routing, record after verifying.** The loop is `recall → … → verify → record`.
- **Lives at `.solana-brain/`** at your repo root — git-trackable and tool-agnostic, deliberately
  _not_ buried in `.claude/`: a skimmable `MEMORY.md` snapshot, durable `profile.md` facts, and
  ADR-style `decisions/`.
- **No slop.** Entries are factual, dated, and specific. Decisions are _superseded_, never silently
  overwritten — and the installer **never wipes** an existing `.solana-brain/`.
- **Key-safe.** Public keys, program IDs, decisions, and rationale only — never a private key or seed.

Surface it with [`/recall`](commands/recall.md); write it with [`/remember`](commands/remember.md).
Full protocol: [`skill/references/memory.md`](skill/references/memory.md).

---

## Routes to the ecosystem (doesn't reinvent it)

The brain's value is **classification + orchestration + verification** — not re-implementing skills
that already exist. At the leaf of every route, it delegates to the best specialist:

| Cluster | Delegates depth to |
|---|---|
| 🛠 **BUILD** | `solana-dev` (Foundation) · `pinocchio` (SendAI) · `solana-client-layer` · `sendai` / `jupiter` (DeFi) · `metaplex` (NFTs) · `eth-to-sol` · `solana-mobile` · `solana-game` |
| 🚀 **SHIP** | `helius` · `quicknode` · `cloudflare` · `vercel` · `surfpool` |
| 🛡 **SECURE** | `trailofbits` · `sendai` (vulnhunter) · `qedgen` (formal verification) · `safe-solana-builder` · `solana-client-layer` (tx-safety) |
| 📈 **GROW** | `colosseum` (Copilot) · `solana-new` (SendAI) · `sendai` (launchpads) |
| 🏛 **OPERATE** | `crypto-legal` (US/EU/BR/IN) · `solana-accounting` |

This is why the brain stays **small and current**: it links and routes, it doesn't duplicate. Full
map in [`skill/references/ecosystem-map.md`](skill/references/ecosystem-map.md).

---

## Agents & commands

**Executive team** — six agents, invoked automatically by the router:

| Agent | Role | Model |
|---|---|---|
| [`chief-of-staff`](agents/chief-of-staff.md) | Orchestrator — classifies, routes, sequences multi-cluster work, holds the plan | opus |
| [`build-lead`](agents/build-lead.md) | Programs + client apps | opus |
| [`ship-lead`](agents/ship-lead.md) | Infra, deploy, reliability | sonnet |
| [`secure-lead`](agents/secure-lead.md) | Security across program / client / ops | opus |
| [`grow-lead`](agents/grow-lead.md) | GTM, token, community, fundraising | sonnet |
| [`operate-lead`](agents/operate-lead.md) | Legal, tax, treasury, entity, hiring | sonnet |

**Commands** — each maps to a real workflow, most span multiple clusters:

| Command | Spans | Purpose |
|---|---|---|
| [`/brain`](commands/brain.md) | any | Universal entry — intake + route to the right cluster(s) |
| [`/company-setup`](commands/company-setup.md) | OPERATE + BUILD | 0→1: entity, repo, environments, baseline |
| [`/ship-it`](commands/ship-it.md) | BUILD + SHIP + SECURE | Mainnet-readiness gate → deploy |
| [`/launch-token`](commands/launch-token.md) | BUILD + SECURE + GROW + OPERATE | End-to-end token launch with gates |
| [`/raise`](commands/raise.md) | GROW + OPERATE | Fundraising / hackathon / grant prep |
| [`/incident`](commands/incident.md) | SECURE + SHIP | Incident-response runbook |
| [`/recall`](commands/recall.md) | any | Surface institutional memory before acting |
| [`/remember`](commands/remember.md) | any | Record a decision/fact to institutional memory |

---

## Where it fits in the Solana AI Kit

Complementary, not overlapping. The [Solana AI Kit](https://github.com/solanabr/solana-ai-kit) is a
full dev-config aggregator (agents/commands/rules + ecosystem submodules) focused on **building**.
solana-brain is a single installable **operator's brain** for the **whole company lifecycle** — it
routes across build **and** ship/secure/grow/operate, installs into any repo with one command, injects
a brain-first protocol, and orchestrates gated cross-functional workflows. It **delegates to the kit's
skills** rather than replacing them.

It also follows the kit's reference shape (`solana-game-skill`): a `skill/` folder with a `SKILL.md`
entry point that routes to focused `.md` files (progressive, token-efficient loading), plus optional
`agents/`, `commands/`, `rules/`, an installer, and a clear README — so it slots straight in.

**What makes it production-grade, not slop:**

- ✅ **Useful & recurring** — solves the cross-domain "what's the next move, in what order, with which
  gate" problem every founder/engineer hits, not a toy demo.
- ✅ **Novel** — an orchestration-and-memory layer over the ecosystem; nothing in Solana sequences
  build→secure→operate→grow with gates and remembers the decisions.
- ✅ **Quality** — progressive/token-efficient loading, every install path tested end-to-end (curl,
  npx, global, brew), read-only/key-safe, current to the 2026-06 stack, no shady executables.
- ✅ **Fit** — matches the kit's `SKILL.md`-routing structure, MIT-licensed, ready to be merged or
  submoduled.

---

## Repository structure

```text
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

---

## Safety model

- **Read-only / key-safe by default.** No private keys; the wallet signs; no auto-send or movement of
  funds. See [`rules/safety-and-keys.md`](rules/safety-and-keys.md).
- **OPERATE is informational only.** Legal/tax/compliance guidance is not advice — it cites sources and
  flags counsel/CPA review.
- **Gates are non-negotiable.** SECURE before SHIP/GROW; OPERATE (legal/tax) before a token launch.
- **Current + cited.** Defaults to the 2026 stack, pins "current as of 2026-06", and verifies
  fast-moving specifics against primary docs.

---

## Versioning · Compatibility · Uninstall

- **Versioning** — router/orchestration logic is semver (`0.2.0` — adds institutional memory +
  npm/brew install); fast-moving facts the clusters reference are calendar-pinned `2026-06`. See
  [`skill/references/changelog-pinning.md`](skill/references/changelog-pinning.md).
- **Compatibility** — Claude Code · Codex · Cursor (anything that reads `.claude/` skills + `CLAUDE.md`).
- **Uninstall** — delete `.claude/skills/solana-brain/` and `.solana-brain/`, and remove the fenced
  brain-first block from `CLAUDE.md`. No residue.

---

## Contributing · License

Add clusters/playbooks, expand the ecosystem map, or wire new specialist skills. Keep the brain a
**router** — push depth into specialist skills, not into the brain. Read-only / key-safe; cite primary
docs for time-sensitive specifics.

**MIT** — see [LICENSE](LICENSE).
