---
title: Orchestration — Cross-Functional Playbooks
description: How the brain sequences multi-cluster goals (ship to mainnet, launch a token, raise, incident) with explicit gates between clusters.
---

# Orchestration — Cross-Functional Playbooks

Real company goals span clusters. The brain's job is to sequence them with **gates** — a cluster
doesn't start until the prior gate passes. These playbooks are the brain's value over five separate
skills. Run them via the `chief-of-staff` agent. Current as of 2026-06.

## Principles

- **Gate, don't parallelize blindly.** Security gates precede SHIP and GROW. Legal/tax gates precede a token launch. A failed gate stops the line.
- **Name every cluster a goal touches** up front, even the unglamorous one (OPERATE almost always applies).
- **Each step ends with that cluster's verification** before the next begins.
- **Delegate depth** to the cluster file and its ecosystem skill ([ecosystem-map.md](ecosystem-map.md)).

## Playbook: Start a company (0→1)

```
OPERATE → BUILD → SHIP
```
1. **OPERATE** — entity + jurisdiction decision (Delaware C-corp / Cayman / Wyoming DAO LLC), founder/IP basics, banking, baseline compliance posture. Flag counsel. → [clusters/operate.md](../clusters/operate.md)
2. **BUILD** — scaffold the repo, choose the stack (`@solana/kit`, Anchor/Pinocchio), set conventions. → [clusters/build.md](../clusters/build.md)
3. **SHIP** — devnet environment, CI, secrets hygiene, RPC accounts. → [clusters/ship.md](../clusters/ship.md)
- **Gate to leave:** repo builds + deploys to devnet; entity exists or counsel engaged.

## Playbook: Ship to mainnet

```
BUILD → SECURE (gate) → SHIP
```
1. **BUILD** — feature complete on devnet; tests + client send path solid.
2. **SECURE (hard gate)** — program audit + client tx-safety review + key/upgrade-authority custody plan. → [clusters/secure.md](../clusters/secure.md). **Do not deploy to mainnet without passing this gate.**
3. **SHIP** — mainnet deploy, upgrade-authority via multisig, monitoring + alerts + on-call, rollback plan. → [clusters/ship.md](../clusters/ship.md)
- **Gate to leave:** audit findings resolved/accepted; monitoring live; rollback rehearsed.

## Playbook: Launch a token

```
BUILD → SECURE (gate) → OPERATE (gate) → GROW
```
1. **BUILD** — mint/program (Token-2022 extensions as needed), distribution mechanics, claim flow.
2. **SECURE (gate)** — audit the mint/claim, custody of mint + upgrade authority, drainer-safe claim UX.
3. **OPERATE (gate)** — **the step teams skip and regret**: securities/classification posture by jurisdiction, tax treatment (e.g. US income-recognition; India 30% VDA + 1% TDS), treasury accounting setup. Flag counsel + CPA. → [clusters/operate.md](../clusters/operate.md)
4. **GROW** — TGE plan, airdrop/eligibility, distribution channels, listings, community, post-launch comms. → [clusters/grow.md](../clusters/grow.md)
- **Gate to leave:** audit clean; legal/tax posture documented with counsel; claim UX drainer-reviewed.

## Playbook: Raise / hackathon / grant

```
GROW → OPERATE
```
1. **GROW** — narrative, traction story, demo, deck, target list (VCs / grants / hackathon tracks). → [clusters/grow.md](../clusters/grow.md)
2. **OPERATE** — data room, cap table, entity + SAFT/SAFE readiness, diligence prep. Flag counsel. → [clusters/operate.md](../clusters/operate.md)
- **Gate to leave:** demo works on devnet/mainnet; entity + instruments ready for diligence.

## Playbook: Incident response

```
SECURE (triage/contain) → SHIP (mitigate/restore) → OPERATE (disclosure)
```
1. **SECURE** — triage scope, contain (pause/upgrade if possible), preserve evidence, identify the vector. → [clusters/secure.md](../clusters/secure.md)
2. **SHIP** — deploy mitigation, restore service, add detections. → [clusters/ship.md](../clusters/ship.md)
3. **OPERATE** — user comms, disclosure timing, counsel/regulatory considerations, post-mortem. → [clusters/operate.md](../clusters/operate.md)
- Run via [`/incident`](../../commands/incident.md). Speed matters; do not skip evidence preservation.

## When goals collide

If two playbooks are active (e.g. shipping a feature mid-fundraise), the `chief-of-staff` keeps one
plan, shares the SECURE gate, and sequences by deadline and risk. Surface the tradeoff to the human;
don't silently deprioritize a gate.

---

*Sequencing + gates only; depth lives in the clusters. Current as of 2026-06.*
