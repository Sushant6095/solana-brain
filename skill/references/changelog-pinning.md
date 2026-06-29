---
title: Versioning & Maintenance Cadence
description: How solana-brain is versioned, what's date-sensitive, and how to keep the router and its delegations current.
---

# Versioning & Maintenance Cadence

`solana-brain` carries a semver (`0.1.0`) for the **router/orchestration logic** and a calendar pin
(`2026-06`) for the **fast-moving facts** its clusters reference. The router changes rarely; the
ecosystem underneath it changes constantly.

## How to read the version

- **Router/orchestration** (this skill's own logic): semver. Breaking routing/structure changes bump
  major; new clusters/playbooks bump minor.
- **Facts/specs** (fees, infra, tax rules, SDKs): calendar-pinned `2026-06`. If the user cites newer
  behavior, verify against primary docs before relying.

## Watch list (what goes stale)

| Area | Why | Where |
|---|---|---|
| Delegated skills' availability/names | Ecosystem repos move/rename | [ecosystem-map.md](ecosystem-map.md) |
| Client stack (fees, Jito, WSS metering, `@solana/kit`) | Fast-moving | BUILD / SHIP clusters |
| Audit tooling | New scanners / formal-verification skills | SECURE cluster |
| Tax/legal rules (US 1099-DA phase-in, India VDA, MiCA) | Regulatory change | OPERATE cluster |
| Token-launch mechanics + listing norms | Market-driven | GROW cluster |

## Maintenance checklist

1. Re-verify the [ecosystem-map.md](ecosystem-map.md) targets still exist and are the best choice.
2. Spot-check each cluster's "current as of" facts against primary docs.
3. Confirm the orchestration gates still reflect best practice (esp. audit + legal/tax gates).
4. Bump `metadata.version` (router) and/or the calendar pin (facts); note changes below.

## Change log

- `0.1.0` (`2026-06`) — Initial brain: 5 clusters (build/ship/secure/grow/operate), RESOLVER routing,
  orchestration playbooks (0→1, mainnet, token launch, raise, incident), ecosystem delegation map,
  one-command install + brain-first protocol.

---

*Current as of 2026-06.*
