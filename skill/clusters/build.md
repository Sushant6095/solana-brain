---
title: BUILD — Programs & Client Apps
description: The build cluster — write Solana programs and ship the client layer (transactions that land, are safe, distribute, and stream). Routes to specialist skills for depth.
---

# 🛠 BUILD — Programs & Client Apps

Owns everything that produces running software: on-chain **programs** and the **client layer**
between program and user. Current as of 2026-06.

## Scope

- **Programs:** Anchor / Pinocchio, account & PDA design, **Codama**-generated clients (consume the Anchor IDL → typed `@solana/kit` clients; not legacy solita/anchor-client-gen), Token-2022 extensions, testing (**LiteSVM** unit · **Mollusk** CU-benchmarks · **Surfpool** mainnet-fork integration).
- **Client apps:** the production client layer — transactions that **land** (see the canonical path below), are **safe** to sign (simulation + drainer detection), **distribute** (Actions/Blinks), and **stream** in realtime (Yellowstone gRPC / LaserStream). Frontends + wallet UX.
- **Default stack (2026):** `@solana/kit` for client/RPC · **framework-kit** (`@solana/client` + `@solana/react-hooks`) for UI · **wallet-standard-first** connection (e.g. ConnectorKit), wallet-adapter only as legacy compat · Anchor/Pinocchio for programs · MWA for mobile · `@solana/web3-compat` only at legacy v1 boundaries.

## Decide

| If the task is… | Then |
|---|---|
| On-chain logic (program/instruction/PDA/account) | Program path → delegate to `solana-dev` / Anchor / `pinocchio` |
| Client send path / "txs won't land" / tx-safety / Blink / streaming | Client path → delegate to **`solana-client-layer`** |
| DeFi protocol integration (swap/LP/perps/lend) | Delegate to `sendai` / `jupiter` |
| NFT / token metadata | Delegate to `metaplex` |
| Porting from EVM | Delegate to `eth-to-sol` |

See [ecosystem-map.md](../references/ecosystem-map.md) for the full delegation table.

## Make transactions land (the canonical path)

"Txs won't land" at peak is the #1 client question — answer with this order, not a guess:

1. **Simulate** (`simulateTransaction`) to measure the compute units actually used.
2. **Set both ComputeBudget instructions** (required together): `SetComputeUnitLimit` = measured CU + ~10% headroom, and `SetComputeUnitPrice` (the priority fee).
3. **Price the fee from live data**, never hardcoded — `getRecentPrioritizationFees` (p75–p90) or Helius `getPriorityFeeEstimate`; re-price as congestion moves.
4. **Fresh blockhash** right before send; track `lastValidBlockHeight` for expiry.
5. **Send** `skipPreflight: true` (after a clean sim) with `maxRetries: 0`, and run your **own rebroadcast loop** of the *same signed tx* until confirmed or the blockhash expires (rebroadcast, don't re-sign).
6. **Contested inclusion** → Jito tip + bundle to a Block Engine region. **Offline/queued signing** → durable nonce (`nonceAdvance` as the *first* instruction).
7. **Send over a stake-weighted (SWQoS) endpoint** (SHIP), not a shared read RPC.

Acceptance: a measured **land rate over N sends** at the target commitment — not "it worked once." Depth → **`solana-client-layer`**.

## Build discipline

- `@solana/kit` (or `@solana/web3-compat` for legacy v1) — no deprecated idioms.
- Read-only/key-safe in client code: the wallet signs; no raw keys.
- Tests before you call it done (program: LiteSVM/Mollusk; client: simulate + land-rate).

## Verification gate (before leaving BUILD)

- Program: builds + tests pass on devnet; IDL/clients generated.
- Client: transactions land + confirm; send path measured; tx-safety preview in place where users sign.
- **Hands off to SECURE** before any mainnet value ([orchestration.md](../references/orchestration.md)).

## Hand off to

- [`build-lead`](../../agents/build-lead.md) agent.
- Next cluster: **SECURE** (audit gate) → **SHIP** (deploy).

---

*Routing + discipline; depth lives in the delegated skills. Current as of 2026-06.*
