---
title: Teaching — build it, then make the engineer understand it
description: After engineering work the brain teaches it. The default task→code→done loop is forbidden; optimize for the engineer's understanding of Solana / Rust / Web3 — why it exists, why this design, the tradeoffs, behavior at scale, and the principles in play.
---

# Teaching — build it, then make the engineer understand it

The default AI workflow — **task → prompt → code → done → no understanding** — is **forbidden** here.
After the engineering work lands and verifies, the brain **also teaches it**, optimizing aggressively
for the engineer's understanding. Never stop at "what this code does." Every task you do, you *learn the
code and the systems behind it* — so working with AI grows your skills instead of hollowing them out.

> Triggered automatically after any BUILD / SHIP / SECURE engineering task (see
> [`rules/teach-after-build.md`](../../rules/teach-after-build.md)) and on demand with
> [`/explain`](../../commands/explain.md) ("explain what you built", "teach me this code", "deep dive",
> "learning report").

## What a teaching pass must answer

For everything that changed, cover:

1. **Why does it exist?** The problem in the system that this solves.
2. **Why this design, not another?** The alternatives considered and **why each was rejected.**
3. **What tradeoffs** were made — time, space, complexity, coupling, cost, CU/rent on Solana.
4. **What happens at scale** — 10×, 1000×, 100M users, concurrent access, account contention.
5. **Which principles** are at play — CS (data structures, complexity), language (Rust ownership,
   lifetimes, zero-copy), systems (concurrency, consensus, fees), and Solana-specific ones.
6. **How a Staff engineer reviews it** — the sharp questions they'd ask, the failure modes they'd probe.

## Solana / Rust / Web3 concept lens (lead with these)

Ground the lesson in the concepts that actually bite on Solana — name them explicitly when they apply:

- **Accounts & ownership** — account model, owner / `is_signer` / `is_writable` checks, rent &
  rent-exemption, `realloc`, the 10 MB account size cap.
- **PDAs & CPIs** — seeds & canonical bump, signer seeds, CPI depth limits, the reentrancy surface.
- **Compute & fees** — the 1.4M CU budget, priority fees, the ~1232-byte transaction limit, tx landing.
- **Concurrency & parallelism** — Sealevel parallel execution, read/write locks, account contention,
  why two txs writing the same account serialize.
- **Serialization** — Borsh vs zero-copy (`bytemuck` / `#[account(zero_copy)]`), alignment, 8-byte
  discriminators.
- **Rust** — ownership / borrowing, lifetimes, `Result` / error enums, `checked_*` math (silent overflow
  is a bug), `no_std` constraints in programs, monomorphization & binary size vs CU cost.
- **Security invariants** — signer checks, owner checks, arithmetic overflow, account substitution,
  oracle/price assumptions, upgrade-authority risk.
- **Anchor vs Pinocchio** — what the macros generate, the CU cost of the abstraction, when to drop down.

## How to teach (format)

- **Anchor to the diff.** Teach the code that actually changed — quote `file:line`, not generic theory.
- **Show the rejected path.** "We keyed the PDA on `[b"vault", owner]` instead of one global account
  because a global account serializes every user's writes under Sealevel — here's the measured gap."
- **Tie claims to a number** where you can — CU used, account bytes, rent cost, land rate. If you assert
  a scaling limit, cite the constraint (10 MB account, 1232-byte tx, 1.4M CU).
- **Layer the depth.** One-paragraph "why" → design + tradeoffs → deep dive. Let the reader stop where
  they need to.
- **No hand-waving, no slop.** If something is uncertain or version-sensitive, say so and cite primary
  docs with the date — same accuracy bar as the rest of the brain
  ([accuracy-and-safety.md](accuracy-and-safety.md)).

## Learning report (optional artifact)

For a substantial change, save the lesson so it compounds with the team: `/explain --save` writes
`.solana-brain/lessons/NNNN-topic.md` (key-safe, public data only). A good report = the six answers
above + the concept lens + links to the diff/tx/test.

This pairs with self-evolve: the **lesson** teaches the *human*; a **learning**
([self-evolve.md](self-evolve.md)) updates the *brain*. Same task, two kinds of compounding.

---

*Engineering without understanding is slop. Teach the why, the tradeoffs, and the principles —
Solana / Rust / Web3 first. Cite the diff and the numbers. Current as of 2026-06.*
