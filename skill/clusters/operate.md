---
title: OPERATE — Legal, Tax, Treasury, Entity & Hiring
description: The operate cluster — the back office of a Solana company. Legal/compliance, tax/accounting, treasury, entity formation, and hiring. Informational only — flags counsel/CPA.
---

# 🏛 OPERATE — Legal, Tax, Treasury, Entity & Hiring

Owns running the business around the product — the cluster teams skip and regret, especially on a
token launch. **Informational only — not legal, tax, or financial advice; flag counsel/CPA before
acting.** Current as of 2026-06.

## Scope

- **Entity & structure:** Delaware C-corp / Cayman / Wyoming DAO LLC tradeoffs; founder/IP basics; banking.
- **Legal & compliance:** securities/classification posture (is the token a security), licensing (MSB/BitLicense/MiCA CASP), KYC/AML, sanctions, ToS/privacy — by jurisdiction.
- **Tax & accounting:** crypto-tax treatment, cost basis, staking/airdrop income, 1099-DA, India VDA (30% + 1% TDS), DAO/startup treasury books (FASB).
- **Treasury:** custody (multisig), runway, stablecoin management, reconciliation.
- **Hiring/finance:** contractors, token comp, cap table basics.

## Decide

| If the task is… | Then |
|---|---|
| Legal/compliance/securities/licensing/jurisdiction | Delegate to **`crypto-legal`** (US/EU/BR/IN) |
| Tax / accounting / cost basis / 1099-DA / treasury books | Delegate to **`solana-accounting`** |
| Entity formation tradeoffs | `crypto-legal` jurisdiction router |
| Custody/key control | Coordinate with **SECURE** ([clusters/secure.md](secure.md)) |

## Operate discipline

- **Informational only.** No filed returns, no legal opinions, no moving money. Every substantive
  output flags **counsel/CPA review** and cites the statute/standard.
- **Jurisdiction is explicit** — never silently assume US (a US plan and an India plan differ sharply: e.g. India's flat 30% VDA tax + 1% TDS with no loss set-off).
- Treasury keys behind multisig; books reconcile to the chain.

## Verification gate

- For a token/launch: securities + tax posture documented **with counsel/CPA**, entity in place.
- Treasury custody + accounting baseline established before holding material value.

## Hand off to

- [`operate-lead`](../../agents/operate-lead.md) agent; [`/company-setup`](../../commands/company-setup.md), and the OPERATE gate in [`/launch-token`](../../commands/launch-token.md).
- Gates token launches and fundraises; coordinates with SECURE on custody/compliance.

---

*Routing + discipline; depth lives in the delegated legal/accounting skills. Informational only —
not legal, tax, or financial advice. Current as of 2026-06.*
