---
title: SHIP — Infra, Deploy & Reliability
description: The ship cluster — RPC, deployment, CI/CD, observability, and the reliability/on-call posture that keeps a Solana app live.
---

# 🚀 SHIP — Infra, Deploy & Reliability

Owns getting code to mainnet and keeping it up. Current as of 2026-06.

## Scope

- **RPC & infra:** read RPC, a stake-weighted-QoS (**SWQoS**) **send** path, and a **stream** endpoint — often three different endpoints. SWQoS reserves ~80% of leader TPU capacity for staked submitters; use a named send product: **Helius Sender / Dedicated Staked Connections**, **QuickNode Transaction Fastlane (+Lil'JIT)**, or **Triton** staked connections (self-hosted: `--rpc-send-transaction-tpu-peer`). Don't send over a shared read RPC.
- **Deploy:** program deploy/upgrade (buffer accounts, upgrade authority via a **Squads multisig**) with a **verified build** (`solana-verify`: deterministic Docker build → on-chain verify PDA binding program address + git URL + commit hash; verified status on OtterSec/Explorer). Client/app deploy (Cloudflare/Vercel), environment + secrets hygiene.
- **CI/CD:** build/test/deploy pipelines; devnet-first, mainnet-gated.
- **Observability & on-call:** monitoring, alerting, land-rate/slot-lag dashboards, incident readiness, rollback plans.

## Decide

| If the task is… | Then |
|---|---|
| RPC / DAS / webhooks / priority-fee data / streaming infra | Delegate to `helius` / `quicknode` |
| Edge/app deploy, Workers, Next.js hosting | Delegate to `cloudflare` / `vercel` |
| Local validator / mainnet-fork testing | Delegate to `surfpool` |
| Send-path reliability under load | Delegate to **`solana-client-layer`** (landing) |

## Ship discipline

- **Devnet first, always.** Mainnet deploy is gated on a passed SECURE audit + custody plan.
- Upgrade authority and treasury keys go behind a **multisig** (e.g. Squads), never a single hot key.
- Secrets in env/secret manager; never in the repo or client bundle.
- Pin the cluster (mainnet vs devnet) explicitly; one cluster per environment.

## Verification gate (before "shipped")

- Mainnet deploy reproducible — **verified build hash matches on-chain** (`solana-verify`); upgrade authority multisig-controlled; rollback rehearsed.
- Monitoring + alerts live (RPC health, land rate, error spikes); on-call path defined.
- Incident runbook exists ([`/incident`](../../commands/incident.md)).

## Hand off to

- [`ship-lead`](../../agents/ship-lead.md) agent.
- Pairs with **SECURE** (custody, incident) and **BUILD** (the artifact being shipped).

---

*Routing + discipline; depth lives in the delegated infra skills. Current as of 2026-06.*
