---
title: SECURE — Audits, Tx-Safety, Custody & IR
description: The secure cluster — the cross-cutting gate. Program audits, client/user transaction safety, key and treasury custody, supply chain, and incident response.
---

# 🛡 SECURE — Audits, Tx-Safety, Custody & Incident Response

The cross-cutting **gate**: build and launch paths pass through here before SHIP/GROW. Owns risk
across program, client, and operations. Current as of 2026-06.

## Scope

- **Program audit:** vulnerability review, formal verification, security-first patterns.
- **Client/user tx-safety:** pre-sign simulation + balance/authority diff + drainer-pattern detection (unlimited `Approve`, `SetAuthority`, System `Assign` owner-reassignment, durable-nonce holds). Simulation is necessary, **not** sufficient (anti-sim / TOCTOU).
- **Custody:** key management, multisig (Squads), upgrade-authority control, treasury hygiene, session-key scoping.
- **Supply chain / AppSec:** dependencies, secrets, CI/CD, LLM/skill safety.
- **Incident response:** triage → contain → preserve evidence → mitigate → disclose.

## Decide

| If the task is… | Then |
|---|---|
| Program audit / vuln scan | Delegate to `trailofbits` / `sendai` (vulnhunter, code-recon) |
| Formal verification | Delegate to `qedgen` (Lean 4) |
| Security-first codegen | Delegate to `safe-solana-builder` |
| AppSec (SAST/SCA/secrets) | Delegate to `ghostsecurity` / `defending-code` |
| Client/user transaction safety + drainer detection | Delegate to **`solana-client-layer`** (tx-safety) |
| Custody/compliance overlap (is token a security, licensing) | Coordinate with **OPERATE** ([clusters/operate.md](operate.md)) |

## Security discipline

- **Gate, not afterthought.** No mainnet value without an audit + custody plan ([orchestration.md](../references/orchestration.md)).
- Assume hostile inputs; never declare a transaction "safe" on a clean simulation alone.
- Keys behind multisig; least privilege; rotate; isolate signers from agents.
- Preserve evidence first in an incident; speed second.

## Verification gate

- Findings resolved or explicitly risk-accepted by an owner.
- Custody plan documented (who holds upgrade/treasury authority, multisig threshold).
- For client UX: drainer-safe approval flow with human-readable preview.

## Hand off to

- [`secure-lead`](../../agents/secure-lead.md) agent; [`/incident`](../../commands/incident.md) for live events.
- Gates **SHIP** and **GROW**; coordinates with **OPERATE** on legal/regulatory exposure.

---

*Routing + discipline; depth lives in the delegated security skills. Current as of 2026-06.*
