---
title: RESOLVER — Intent → Cluster Routing
description: The brain's classification table. Map any Solana company request to one or more of the five clusters, then open only those cluster files.
---

# RESOLVER — Intent → Cluster Routing

This is how the brain **classifies**. Read it to decide which cluster(s) a request belongs to, then
open only those files. Multi-cluster routing is the norm — most real goals span several.

## Classify by intent

| Signal / phrasing | Primary cluster | Also touches |
|---|---|---|
| "write/add a program", "Anchor", "Pinocchio", "instruction", "PDA", "account" | BUILD | SECURE |
| "build the app/frontend", "wallet connect", "transaction won't land", "priority fee", "Blink", "stream accounts" | BUILD | SHIP, SECURE |
| "deploy", "devnet/mainnet", "RPC", "CI/CD", "monitoring", "it's slow / falling over", "on-call" | SHIP | SECURE |
| "audit", "is this safe", "vulnerability", "formal verification" | SECURE | BUILD |
| "is this transaction/Blink safe", "we got drained", "key management", "multisig/custody" | SECURE | BUILD, OPERATE |
| "we have an incident / exploit / outage" | SECURE + SHIP | OPERATE |
| "go to market", "users", "growth", "community", "marketing" | GROW | — |
| "launch a token", "airdrop", "TGE", "bonding curve", "listing" | GROW | BUILD, SECURE, OPERATE |
| "raise", "VC", "grant", "hackathon", "pitch", "investor" | GROW | OPERATE |
| "incorporate", "entity", "Delaware/Cayman/Wyoming DAO LLC" | OPERATE | — |
| "taxes", "accounting", "treasury", "cost basis", "bookkeeping", "1099-DA", "VDA / 1% TDS" | OPERATE | — |
| "compliance", "license", "MSB/BitLicense", "MiCA", "KYC/AML", "sanctions", "is my token a security" | OPERATE | SECURE |
| "hiring", "contractor", "token comp", "cap table" | OPERATE | — |
| "what do we do next", "we're launching next month", "help us ship a company" | ALL | orchestrate |

## Multi-cluster goals (route to orchestration)

If the request is a **goal** rather than a task, route to [references/orchestration.md](references/orchestration.md):

| Goal | Clusters, in order |
|---|---|
| Start a company (0→1) | OPERATE (entity) → BUILD (repo/baseline) → SHIP (envs) |
| Ship to mainnet | BUILD → SECURE (audit gate) → SHIP (deploy) |
| Launch a token | BUILD (mint/program) → SECURE (audit) → OPERATE (legal/tax) → GROW (TGE/GTM) |
| Raise / hackathon | GROW (narrative/demo) → OPERATE (data room, entity, SAFT) |
| Respond to an incident | SECURE (triage/contain) → SHIP (mitigate/restore) → OPERATE (disclosure/counsel) |

## Disambiguation rules

- **Default to asking the brain, not guessing.** If a request could be two clusters, name both and
  proceed with the dominant one; don't silently drop the secondary (e.g. a token launch is never
  "just GROW" — it always carries SECURE + OPERATE).
- **Stage matters.** The same words mean different things pre-devnet vs at scale; cross-check
  [references/company-lifecycle.md](references/company-lifecycle.md).
- **Delegate at the leaf.** Once in a cluster, prefer an existing ecosystem skill for depth
  ([references/ecosystem-map.md](references/ecosystem-map.md)). The brain routes; the specialist executes.
- **Security is a cross-cutting gate, not an afterthought.** Any "build" or "launch" path passes a
  SECURE gate before SHIP/GROW.

## Output of classification

State, briefly: the matched cluster(s), why, the entry file(s) to open, and — if multi-cluster — the
orchestration playbook and sequence. Then proceed.

---

*Routing only. Depth lives in the clusters and the skills they delegate to. Current as of 2026-06.*
