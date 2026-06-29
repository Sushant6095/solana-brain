---
title: Ecosystem Map — Delegate, Don't Duplicate
description: Which existing skills each cluster routes to for depth. solana-brain orchestrates; the specialists execute.
---

# Ecosystem Map — Delegate, Don't Duplicate

The brain's value is classification + orchestration + verification — **not** re-implementing skills
that already exist. At the leaf of a route, prefer a specialist skill. This map is orientation;
confirm availability in the user's setup (many ship in the Solana AI Kit or as standalone skills).
Current as of 2026-06.

## BUILD

| Need | Delegate to |
|---|---|
| Core program dev, frontend, testing patterns | `solana-dev` (Solana Foundation) |
| Anchor depth | Anchor skill / `quicknode-anchor` reference |
| Pinocchio / CU optimization | `pinocchio` (SendAI) |
| Client layer: tx landing, safety, Actions/Blinks, streaming | **`solana-client-layer`** (vertical skill) |
| DeFi protocol calls (swaps, LP, perps, lending) | `sendai` (Jupiter, Orca, Raydium, Meteora, Kamino…), `jupiter` |
| NFTs / token metadata / candy machine | `metaplex` |
| EVM → Solana porting | `eth-to-sol` (Solana Foundation) |
| Mobile | `solana-mobile` |
| Games / Unity | `solana-game` |

## SHIP

| Need | Delegate to |
|---|---|
| RPC, DAS, webhooks, priority-fee data, streaming infra | `helius`, `quicknode` |
| Edge / Workers / deploy infra | `cloudflare`, `vercel` |
| Local validator / mainnet-fork testing | `surfpool` |
| Reliability of the send path itself | **`solana-client-layer`** (landing pillar) |

## SECURE

| Need | Delegate to |
|---|---|
| Program audit, vulnerability scanning | `trailofbits`, `sendai` (vulnhunter / code-recon) |
| Formal verification (Lean 4) | `qedgen` |
| Security-first code generation | `safe-solana-builder` |
| AppSec (SAST/SCA/secrets) | `ghostsecurity`, `defending-code` |
| Client/user tx-safety + drainer detection | **`solana-client-layer`** (tx-safety pillar) |

## GROW

| Need | Delegate to |
|---|---|
| Idea validation, startup research, hackathon prep | `colosseum` (Colosseum Copilot) |
| Idea→launch journey, GTM datasets | `solana-new` (SendAI) |
| Token launch mechanics (bonding curves, launchpads) | `sendai` (pumpfun, raydium launchlab) |

## OPERATE

| Need | Delegate to |
|---|---|
| Legal / compliance / securities / licensing / jurisdictions | **`crypto-legal`** (vertical skill; US/EU/BR/IN) |
| Tax, accounting, treasury, cost basis, 1099-DA, DAO books | **`solana-accounting`** (vertical skill) |
| Entity formation tradeoffs | `crypto-legal` (jurisdiction router) |

## Delegation rules

1. **Check before building.** If a specialist owns the depth, route to it and add only the
   orchestration/glue.
2. **Brain adds the connective tissue** specialists don't: cross-cluster sequencing, gates, and
   "what to do next."
3. **If no specialist exists**, the cluster file carries enough to act, and notes it as a gap for a
   future vertical skill.
4. **Never duplicate** a specialist's content into the brain; link/route instead. This keeps the
   brain small and current.

---

*Orientation only; confirm which skills are installed. Current as of 2026-06.*
