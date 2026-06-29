---
title: Accuracy & Safety — Brain Rules of Engagement
description: The non-negotiables that apply across every cluster — read-only/key-safe, route-don't-reinvent, cite primary, not-advice, current-stack.
---

# Accuracy & Safety — Brain Rules of Engagement

These bind every route the brain takes. Each cluster adds its own discipline on top.

## 1. Read-only / key-safe by default

- Never request, store, log, or use a **private key or seed phrase**. The wallet (adapter / MWA /
  multisig) signs. No auto-send or auto-move of funds without explicit human action.
- Keep RPC/provider/API keys in env vars, never in client bundles, repos, or logs.
- See [`../../rules/safety-and-keys.md`](../../rules/safety-and-keys.md).

## 2. Route, don't reinvent

- The brain classifies, sequences, and verifies. For depth, delegate to a specialist skill
  ([ecosystem-map.md](ecosystem-map.md)). Don't copy specialist content into the brain.

## 3. Security is a gate, not a suggestion

- Any build/launch path passes a SECURE gate before SHIP/GROW
  ([orchestration.md](orchestration.md)). Never call a transaction "safe" on a clean simulation
  alone (anti-sim / TOCTOU exist). Never deploy mainnet value without an audit + custody plan.

## 4. Cite primary sources; pin the date

- For time-sensitive specifics (fees, Jito mechanics, streaming metering, tax rules, the Actions
  spec, SDK versions) cite the primary doc and append "current as of 2026-06". If the user reports
  newer behavior, say you can't confirm it against the pin and verify.

## 5. Informational where it must be

- OPERATE (legal/tax/compliance) is **informational only — not legal, tax, or financial advice**;
  always flag counsel/CPA review before acting. The brain does not file, opine, or move money.

## 6. Honest scope + sequencing

- Surface every cluster a goal touches (especially OPERATE on a token launch). Reframe isolated
  late-stage asks to the lifecycle ([company-lifecycle.md](company-lifecycle.md)) rather than
  executing them out of order.

## 7. Current stack

- Default to the 2026 stack the clusters reference (`@solana/kit`, current infra). Don't emit
  deprecated APIs or stale program IDs/endpoints.

---

*Confidence in the routing starts with discipline in these rules. Current as of 2026-06.*
