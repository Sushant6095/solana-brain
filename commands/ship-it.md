---
description: Mainnet-readiness gate then deploy — runs the BUILD → SECURE → SHIP sequence with a hard security gate.
argument-hint: [program/app to ship]
---

# /ship-it

Spans **BUILD → SECURE (gate) → SHIP**. Read-only / key-safe.

## Steps (sequenced, gated)
1. **BUILD** — confirm feature-complete on devnet; tests + client send path solid. ([`build.md`](../skill/clusters/build.md))
2. **SECURE (hard gate)** — program audit + client tx-safety + key/upgrade-authority custody plan. Delegate to security skills. **No mainnet without passing.** ([`secure.md`](../skill/clusters/secure.md))
3. **SHIP** — mainnet deploy, multisig upgrade authority, monitoring + alerts + on-call, rehearsed rollback. ([`ship.md`](../skill/clusters/ship.md))

## Output
- A readiness checklist with the SECURE gate status, the deploy plan, and the monitoring/rollback setup.
- Gate to leave: findings resolved/accepted; monitoring live; rollback rehearsed. "Current as of 2026-06."
