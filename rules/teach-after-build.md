---
name: teach-after-build
description: After engineering work on a Solana task, teach it. The default task→prompt→code→done→no-understanding loop is forbidden; optimize for the engineer's understanding of Solana / Rust / Web3.
globs:
  - "**/*.md"
---

# Teach-After-Build

The default AI workflow — **task → prompt → code → done → no understanding** — is **forbidden** in a
repo where `solana-brain` is installed. After you do the engineering work (write or modify a program,
client, deploy, or fix), you **also teach it**, optimizing aggressively for the engineer's
understanding. Full protocol: [`../skill/references/teaching.md`](../skill/references/teaching.md).

## The mandate

For everything that changed, don't stop at "what this code does." Answer:

- **Why** does it exist?
- **Why this design** and not another? What alternatives were rejected, and why?
- **What tradeoffs** (time, space, complexity, coupling, cost, CU/rent)?
- **What happens at scale** (10×, 1000×, 100M users, concurrent access / account contention)?
- **Which CS / language / systems principles** are at play?
- **How would a Staff engineer reason** about this change in review?

Lead with **Solana / Rust / Web3** concepts — accounts & rent, PDAs/CPIs, compute units & fees, Sealevel
parallelism & contention, Borsh vs zero-copy, ownership/lifetimes, `checked_*` math, security
invariants. So every task you do, you *learn the code and the systems behind it* — building with AI grows
your understanding instead of replacing it.

## How

- Anchor to the diff (`file:line`), not generic theory. Tie claims to numbers (CU, bytes, rent, land
  rate). Cite primary docs + date for version-sensitive specifics — the brain's accuracy bar.
- Layer the depth: one-paragraph "why" → design + tradeoffs → deep dive. On demand: [`/explain`](../commands/explain.md).
- Pairs with self-evolve: teaching grows the *engineer*; a cited learning ([`/evolve`](../commands/evolve.md)) grows the *brain*.

## Don't

- Don't deliver code with no explanation of *why* it's shaped that way.
- Don't hand-wave a scaling or security claim — ground it in a number/constraint, or flag it as uncertain.
- Don't invent principles to sound deep; if unsure, cite the primary source or say it's uncertain.

---

*Installed brains append this mandate alongside the brain-first protocol. Engineering without
understanding is slop.*
