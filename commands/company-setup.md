---
description: Stand up a Solana company 0→1 — entity decision, repo + stack baseline, and devnet environment.
argument-hint: [project name] [jurisdiction hint]
---

# /company-setup

Spans **OPERATE + BUILD + SHIP**. Read-only / key-safe; OPERATE is informational (flag counsel).

## Steps (sequenced)
1. **OPERATE** — entity/jurisdiction tradeoffs (Delaware/Cayman/Wyoming DAO LLC), founder/IP basics; delegate to `crypto-legal`. Flag counsel. ([`operate.md`](../skill/clusters/operate.md))
2. **BUILD** — scaffold repo, pick stack (`@solana/kit`, Anchor/Pinocchio), set conventions. ([`build.md`](../skill/clusters/build.md))
3. **SHIP** — devnet environment, CI, secrets hygiene, RPC accounts. ([`ship.md`](../skill/clusters/ship.md))

## Output
- An entity/jurisdiction recommendation (counsel-flagged), a scaffolded repo plan, and a devnet env checklist.
- Gate to leave: repo builds + deploys to devnet; entity exists or counsel engaged. "Current as of 2026-06."
