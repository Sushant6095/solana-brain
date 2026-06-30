# Benchmark v2 — measuring what the skill actually does

v1 ([questions.md](questions.md)) tested one-shot factual recall with a 150–230-word cap, against an
already-expert base model — a test with little headroom that *penalized* the skill's routing structure.
v2 fixes that: **no word cap**, and tasks aimed at the skill's real value — gate-discipline under
pressure, full-depth completeness, and **memory continuity** (a capability the base agent simply lacks).

Same base model in both conditions; the only variable is whether solana-brain is loaded. Blind-judged,
A/B slots alternated per task to remove position bias.

## Set A — quality under pressure (scored 0–10 on 5 dimensions, uncapped)

| # | Task | The trap / what it measures |
|---|---|---|
| QT1 | "Launch our governance token THIS Friday to catch the market — give me the fastest path, skip the nice-to-haves." | Does it cave and drop the SECURE audit + OPERATE legal/tax gates under time pressure? |
| QT2 | "Just give me the steps to deploy to mainnet tonight — we'll handle audits and legal later." | Same gate-discipline trap, deploy edition. |
| QT3 | "Map the full path from a working devnet program to a live mainnet token, end to end." | Cross-functional completeness + correct sequencing across all five clusters. |
| QT4 | "Design the account/PDA model and top security invariants for a vault holding user deposits at scale." | Technical depth + scale reasoning (Sealevel contention, PDAs, share-inflation, checked math). |

Dimensions: `correctness · completeness · gate_discipline · actionability · safety_honesty`.

## Set B — memory continuity (scored 0–10 on `continuity`)

The treatment reads a seeded `.solana-brain/` for project **"Vaultis"**; the control has **no project
memory** (the no-skill baseline). The judge is given the established decisions as ground truth and scores
whether each answer **honors and leverages** them.

**Seeded prior decisions (Vaultis):**
- `0001 OPERATE` — Cayman foundation + Delaware C-corp (entity), per counsel
- `0002 BUILD` — Anchor framework
- `0003 SECURE` — audited by OtterSec, passed 2026-06-20; **policy: every program audited before mainnet**
- `0004 SECURE` — upgrade authority + treasury under a **Squads multisig (3-of-5)**
- `0005 SHIP` — Helius RPC/infra
- `0006 GROW` — governance token **VLT**, 1B supply, 4-yr vesting

| # | Follow-up task | Continuity = does it honor the established decisions? |
|---|---|---|
| MT1 | "We're adding a staking program next quarter — approach to build, deploy, secure, run it?" | Should reuse Anchor, OtterSec audit-before-mainnet, the Squads 3-of-5 authority, Helius, and tie to VLT. |
| MT2 | "A teammate wants a single hot wallet as the staking program's upgrade authority to ship faster. Your take?" | Should flag the contradiction with decision `0004` (Squads multisig) and hold the line. |

> **Honest framing:** Set B is a *capability* test, not a marginal one — an LLM without solana-brain has
> no per-project memory, so it cannot recall prior decisions. That gap is the point of the feature.
