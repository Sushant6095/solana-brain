---
title: Company Lifecycle — What Each Stage Needs
description: idea → devnet → mainnet → scale, and which clusters carry weight at each stage. The brain uses stage to disambiguate routing.
---

# Company Lifecycle — What Each Stage Needs

The same request means different things at different stages. The brain reads stage to route well —
"launch" pre-product ≠ "launch" at scale. Current as of 2026-06.

## Stages and cluster weight

| Stage | What it is | Heaviest clusters | Typical asks |
|---|---|---|---|
| **0 — Idea** | validating the problem | GROW, OPERATE | "is this worth building", entity basics, hackathon |
| **1 — Devnet** | building the thing | BUILD, SHIP | program + app on devnet, CI, environments |
| **2 — Audit/Pre-mainnet** | hardening | SECURE, BUILD | audit, tx-safety, key/custody plan, mainnet-readiness |
| **3 — Mainnet** | live with real value | SHIP, SECURE | deploy, monitoring, on-call, incident readiness |
| **4 — Token / GTM** | distribution | GROW, OPERATE, SECURE | TGE, airdrop, legal/tax posture, growth |
| **5 — Scale** | operating a company | OPERATE, SHIP | treasury/accounting, hiring, reliability, compliance cadence |

## Stage gates (don't skip)

- **1 → 2:** feature-complete on devnet with tests before you pay for an audit.
- **2 → 3:** **audit + custody plan before mainnet value.** Non-negotiable gate.
- **3 → 4:** stable mainnet + monitoring before you concentrate attention with a token/launch.
- **4:** legal/tax posture (OPERATE) decided *with counsel/CPA* before TGE — see [orchestration.md](orchestration.md).

## How the brain uses stage

1. Infer stage from the repo + the request (no mainnet deploy config + "launch" usually means devnet milestone, not TGE).
2. If stage is ambiguous and it changes the answer, ask one question ("are we pre- or post-mainnet?").
3. Weight the routing toward the stage's heavy clusters, but always surface a skipped gate (e.g. "you're asking about GROW at stage 4, but I don't see the SECURE/OPERATE gates done").

## Anti-pattern

Treating a later-stage ask in isolation: "help me airdrop a token" at stage 1 with no program, no
audit, and no entity is a sequencing problem, not an airdrop task. The brain reframes to the
lifecycle and routes to the missing prerequisites first.

---

*Stage is a routing input, not a rulebook. Current as of 2026-06.*
