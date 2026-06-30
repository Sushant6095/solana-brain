---
name: solana-brain
description: |
  The brain for building and operating an entire Solana company. One installable skill that acts as
  an intelligent router over five clusters — BUILD (programs + client apps), SHIP (infra, deploy,
  reliability), SECURE (audits, tx-safety, custody, IR), GROW (GTM, token launch, community,
  fundraising), and OPERATE (legal, tax, treasury, entity, hiring). It does not re-implement the
  ecosystem; it classifies any request, routes it to the right cluster(s), orchestrates
  cross-functional workflows (a token launch touches four clusters), and delegates to the best
  existing skills. Use it as the default entry point for ANY Solana company question — "build X",
  "deploy/ship", "is this safe", "launch a token", "raise / hackathon", "incorporate / taxes /
  treasury", "we have an incident", "what do we do next". Install once into a repo; it consults
  itself before ad-hoc action (brain-first). Read-only / key-safe by default — the wallet signs.
user-invocable: true
license: MIT
compatibility:
  - claude-code
  - codex
  - cursor
metadata:
  version: "0.2.0"
  release: "2026-06"
  model: brain-router
  clusters: [build, ship, secure, grow, operate]
  memory: true
  read-only-default: true
  last-stack-review: "2026-06-15"
---

# solana-brain — Build & Operate an Entire Solana Company

**Search gives you skills. The brain gives you the move.** `solana-brain` is one installable
router that knows the whole job of a Solana company — not just how to write a program, but how to
ship it, secure it, grow it, and run the business around it. You install it once; it becomes the
default first stop for any Solana question and routes to the right depth.

> **What this is (and isn't).** This is a **single skill that orchestrates**, not another vertical
> skill and not a fork of any dev-config kit. It classifies intent, routes to one of five clusters,
> composes cross-functional workflows, and **delegates to existing ecosystem skills** instead of
> duplicating them ([ecosystem-map.md](references/ecosystem-map.md)). Think chief-of-staff, not
> encyclopedia.

> **Read-only / key-safe by default.** The brain plans, builds, simulates, and reviews. It never
> asks for or uses a private key/seed, and never auto-signs or moves funds without explicit human
> action. The wallet signs. See [`rules/safety-and-keys.md`](../rules/safety-and-keys.md).

## The five clusters

| Cluster | Owns | Router |
|---|---|---|
| 🛠 **BUILD** | Programs (Anchor/Pinocchio) + client apps (tx landing, safety, Actions/Blinks, streaming, frontends) | [clusters/build.md](clusters/build.md) |
| 🚀 **SHIP** | Infra, RPC, deploy, CI/CD, observability, reliability, on-call readiness | [clusters/ship.md](clusters/ship.md) |
| 🛡 **SECURE** | Program audits, client tx-safety, key/treasury custody, supply chain, incident response | [clusters/secure.md](clusters/secure.md) |
| 📈 **GROW** | GTM, token launch, community, fundraising, hackathons, growth analytics | [clusters/grow.md](clusters/grow.md) |
| 🏛 **OPERATE** | Legal/compliance, tax/accounting, treasury, entity formation, hiring/finance | [clusters/operate.md](clusters/operate.md) |

> Links resolve relative to this file (`skill/SKILL.md`): clusters live in `clusters/`, deeper
> references in `references/`, and agents/commands/rules one level up at the repo root.

## How the brain works (the loop)

```
recall  →  intake  →  classify  →  route  →  orchestrate  →  hand off  →  verify  →  record  →  teach  →  evolve
```

0. **Recall.** Read the project's memory first — `.solana-brain/MEMORY.md`
   ([memory.md](references/memory.md)). Honor prior decisions and gates already cleared; surface the
   relevant one to the user. A fresh repo with no memory is fine — note it and move on.
1. **Intake.** Read the request and the repo context. Identify the stage of the company
   ([company-lifecycle.md](references/company-lifecycle.md)) and ask at most 1–2 clarifying questions
   only if routing is genuinely ambiguous.
2. **Classify.** Map the request to one or more of the five clusters using
   [RESOLVER.md](RESOLVER.md). Multi-cluster is normal and expected.
3. **Route.** Open only the cluster file(s) needed — progressive disclosure. Each cluster decides
   whether to answer directly, route to a deeper reference, or **delegate to an ecosystem skill**.
4. **Orchestrate.** For cross-functional goals, follow the playbooks in
   [orchestration.md](references/orchestration.md) (e.g. token launch = Build → Secure → Grow →
   Operate, sequenced with gates).
5. **Hand off.** Invoke the right cluster lead agent (or the `chief-of-staff` orchestrator for
   multi-cluster work) and the relevant command.
6. **Verify.** Every cluster ends with a check (tests, simulation, land rate, a counsel/CPA review
   flag, a launch checklist). The brain does not call a job done without its cluster's verification.
7. **Record.** Write what changed back to memory ([memory.md](references/memory.md)) — update
   `.solana-brain/MEMORY.md`, and for consequential/gated/irreversible choices add a decision record.
   No slop, key-safe — public data, decisions, and rationale only.
8. **Teach.** After engineering work, *also teach it* — why it exists, why this design over the
   alternatives, the tradeoffs, behavior at scale, the Solana/Rust/Web3 principles, and how a Staff
   engineer would review it. The task→code→done loop with no understanding is forbidden
   ([teaching.md](references/teaching.md), [`/explain`](../commands/explain.md)).
9. **Evolve.** If the verified task left cited evidence worth keeping, record **one grounded learning**
   to `.solana-brain/learnings.md` so the next recall is sharper — no evidence, no entry; the skill
   never rewrites itself ([self-evolve.md](references/self-evolve.md), [`/evolve`](../commands/evolve.md)).

## Routing — the fast path

Use [RESOLVER.md](RESOLVER.md) for the full intent→cluster table. Quick signals:

| The user says… | Cluster(s) | Start |
|---|---|---|
| "write a program / build the app / why do txs fail" | BUILD | [clusters/build.md](clusters/build.md) |
| "deploy / mainnet / RPC / monitoring / it's slow" | SHIP | [clusters/ship.md](clusters/ship.md) |
| "is this safe / audit / keys / we got drained" | SECURE | [clusters/secure.md](clusters/secure.md) |
| "launch a token / users / raise / hackathon" | GROW (+ SECURE + OPERATE) | [clusters/grow.md](clusters/grow.md) |
| "incorporate / taxes / treasury / compliance / hire" | OPERATE | [clusters/operate.md](clusters/operate.md) |
| "we're launching next month — what do we do" | ALL (orchestrate) | [orchestration.md](references/orchestration.md) |
| "I don't know where to start" | brain decides | `/brain` + RESOLVER.md |

## Agents

| Agent | Role | Model |
|---|---|---|
| [`chief-of-staff`](../agents/chief-of-staff.md) | Orchestrator — classifies, routes, sequences multi-cluster work, holds the plan | opus |
| [`build-lead`](../agents/build-lead.md) | Programs + client apps | opus |
| [`ship-lead`](../agents/ship-lead.md) | Infra, deploy, reliability | sonnet |
| [`secure-lead`](../agents/secure-lead.md) | Security across program/client/ops | opus |
| [`grow-lead`](../agents/grow-lead.md) | GTM, token, community, fundraising | sonnet |
| [`operate-lead`](../agents/operate-lead.md) | Legal, tax, treasury, entity, hiring | sonnet |

## Commands

| Command | Spans | Purpose |
|---|---|---|
| [`/brain`](../commands/brain.md) | any | Universal entry — intake + route to the right cluster(s) |
| [`/company-setup`](../commands/company-setup.md) | OPERATE + BUILD | 0→1: entity, repo, environments, baseline |
| [`/ship-it`](../commands/ship-it.md) | BUILD + SHIP + SECURE | Mainnet-readiness gate → deploy |
| [`/launch-token`](../commands/launch-token.md) | BUILD + SECURE + GROW + OPERATE | End-to-end token launch with gates |
| [`/raise`](../commands/raise.md) | GROW + OPERATE | Fundraising / hackathon / grant prep |
| [`/incident`](../commands/incident.md) | SECURE + SHIP | Incident response runbook |
| [`/recall`](../commands/recall.md) | any | Surface institutional memory before acting |
| [`/remember`](../commands/remember.md) | any | Record a decision/fact to institutional memory |
| [`/explain`](../commands/explain.md) | any (post-build) | Teach what you built — why/tradeoffs/scale/principles (Solana/Rust/Web3) |
| [`/evolve`](../commands/evolve.md) | any | Capture a cited, grounded learning so the brain sharpens — no hallucination |

## Progressive Disclosure Map

```
skill/SKILL.md (the brain — you are here)
  ├── RESOLVER.md                      ← intent → cluster routing table (read to classify)
  ├── clusters/
  │     ├── build.md   ├── ship.md   ├── secure.md   ├── grow.md   └── operate.md
  └── references/
        ├── orchestration.md           ← cross-functional playbooks (multi-cluster goals)
        ├── ecosystem-map.md           ← which existing skills each cluster delegates to
        ├── company-lifecycle.md       ← idea → devnet → mainnet → scale; needs per stage
        ├── memory.md                  ← institutional memory: recall before, record after
        ├── self-evolve.md             ← get sharper every prompt from cited evidence (no hallucination)
        ├── teaching.md                ← build it, then teach it (why/tradeoffs/scale/principles)
        ├── accuracy-and-safety.md     ← read-only/key-safe, cite primary, current-stack, not advice
        └── changelog-pinning.md       ← maintenance cadence

Per-project memory (written by the brain, lives at the repo root, not in .claude/):
  .solana-brain/
    ├── MEMORY.md     ← snapshot + decisions index (recall reads this first)
    ├── profile.md    ← durable company facts
    ├── learnings.md  ← evidence-grounded learnings the brain evolves (recall reads this too)
    └── decisions/    ← one ADR-style record per consequential decision
```

Load only the cluster/reference the current request needs.

## Brain-first protocol

Once installed, the agent **consults solana-brain before ad-hoc action** on any Solana task:
recall → classify → route → use the cluster's guidance/skill → verify → record. The installer appends
this protocol to the project's `CLAUDE.md`/`AGENTS.md`. See [`rules/brain-first.md`](../rules/brain-first.md).

## Memory — the company's long-term brain

The brain **remembers**. It keeps per-project institutional memory at `.solana-brain/` (repo root,
git-trackable, separate from the read-only skill): a `MEMORY.md` snapshot, durable `profile.md` facts,
and ADR-style `decisions/`. Every session **recalls before routing** and **records after verifying**,
so decisions, gates, and rationale survive across sessions and never get re-litigated. Use
[`/recall`](../commands/recall.md) to surface it and [`/remember`](../commands/remember.md) to write it.
Key-safe: public data, decisions, and rationale only — never a private key. See
[memory.md](references/memory.md).

## Guardrails

1. **Route, don't reinvent.** If an ecosystem skill owns the depth, delegate to it
   ([ecosystem-map.md](references/ecosystem-map.md)). The brain's value is classification +
   orchestration + verification.
2. **Read-only / key-safe.** No private keys; the wallet signs; no auto-send/move of funds.
3. **Each cluster carries its own discipline.** BUILD/SHIP measure; SECURE assumes hostile inputs
   and never calls a clean simulation "safe"; OPERATE is informational and flags
   counsel/CPA review; GROW avoids hype and unverifiable claims.
4. **Cite primary sources** and **pin the date** ("current as of 2026-06") for fast-moving specifics.
5. **Multi-cluster honesty.** Surface every cluster a goal touches; don't ship a token plan that
   ignores the legal/tax cluster.
6. **Remember, don't repeat.** Recall memory before deciding and record after; never re-litigate a
   settled decision or silently contradict a recorded one. Memory is key-safe — no secrets, ever.
7. **Teach what you build.** After engineering work, explain the why, the tradeoffs, the behavior at
   scale, and the Solana/Rust/Web3 principles — the task→code→done loop with no understanding is
   forbidden ([teaching.md](references/teaching.md)).
8. **Evolve only on evidence.** Capture a learning only if it cites a real artifact; mark unconfirmed
   ones as hypotheses, and never invent one. The skill never rewrites itself — learnings live in memory,
   key-safe ([self-evolve.md](references/self-evolve.md)).

---

*solana-brain v0.2.0 — current as of 2026-06. Read-only / key-safe by default. An orchestrator that
routes to the ecosystem and remembers every decision; verify time-sensitive specifics against primary docs.*
