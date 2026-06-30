---
description: Teach what you just built — why it exists, why this design over the alternatives, the tradeoffs, behavior at scale, and the Solana/Rust/Web3 principles in play. The default task→code→done loop is forbidden; optimize for the engineer's understanding. Add --save to write a learning report.
argument-hint: "[what to explain — a file, the last change, or a concept; blank = the most recent engineering work] [--save]"
---

# /explain  ·  teach me this code · deep dive · learning report

Build it, then make me understand it. Optimize aggressively for understanding — never stop at "what
this code does." Protocol: [`teaching.md`](../skill/references/teaching.md).

## Steps
1. **Scope it.** No argument → teach the most recent engineering change (the diff / files just written).
   An argument → teach that file, change, or concept.
2. **Answer, anchored to the actual code** (quote `file:line`, not generic theory):
   **Why** it exists · **Why this design** and what alternatives were rejected · **Tradeoffs** (time,
   space, complexity, coupling, cost, CU/rent) · **At scale** (10×, 1000×, 100M, concurrency) ·
   **Principles** (CS / Rust / systems / Solana) · **How a Staff engineer** would review it.
3. **Lead with the Solana/Rust/Web3 concept lens** ([`teaching.md`](../skill/references/teaching.md)) —
   accounts & rent, PDAs/CPIs, CU & fees, Sealevel concurrency, Borsh/zero-copy, ownership/lifetimes,
   `checked_*` math, security invariants. Name the ones that actually apply to this change.
4. **Ground it.** Tie claims to numbers (CU, account bytes, rent, land rate) where possible; cite primary
   docs + date for version-sensitive specifics. No slop, no hand-waving.
5. **`--save`** → write `.solana-brain/lessons/NNNN-topic.md` (key-safe) so the lesson compounds.

## Output
- A layered lesson: one-paragraph "why" → design + tradeoffs → deep dive, so the reader stops at the
  depth they need. With `--save`, also the saved learning-report path. Key-safe — never echo a secret.
