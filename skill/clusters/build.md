---
title: BUILD — Programs & Client Apps
description: The build cluster — write Solana programs and ship the client layer (transactions that land, are safe, distribute, and stream). Routes to specialist skills for depth.
---

# 🛠 BUILD — Programs & Client Apps

Owns everything that produces running software: on-chain **programs** and the **client layer**
between program and user. Current as of 2026-06.

## Scope

- **Programs:** Anchor / Pinocchio, account & PDA design, IDL/codegen, Token-2022 extensions, testing (LiteSVM/Mollusk).
- **Client apps:** the production client layer — transactions that **land** (compute budget, priority fees, Jito, durable nonces, rebroadcast/confirm), are **safe** to sign (simulation + drainer detection), **distribute** (Actions/Blinks), and **stream** in realtime (Yellowstone gRPC / LaserStream). Frontends + wallet UX.
- **Default stack (2026):** `@solana/kit`, Anchor/Pinocchio, Next.js + wallet adapter / MWA.

## Decide

| If the task is… | Then |
|---|---|
| On-chain logic (program/instruction/PDA/account) | Program path → delegate to `solana-dev` / Anchor / `pinocchio` |
| Client send path / "txs won't land" / tx-safety / Blink / streaming | Client path → delegate to **`solana-client-layer`** |
| DeFi protocol integration (swap/LP/perps/lend) | Delegate to `sendai` / `jupiter` |
| NFT / token metadata | Delegate to `metaplex` |
| Porting from EVM | Delegate to `eth-to-sol` |

See [ecosystem-map.md](../references/ecosystem-map.md) for the full delegation table.

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
