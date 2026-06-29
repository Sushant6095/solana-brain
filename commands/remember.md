---
description: Record a decision or durable fact into the project's institutional memory — writes an ADR-style decision record and updates the MEMORY.md snapshot and company profile. No slop, key-safe.
argument-hint: <the decision or fact — e.g. "chose Cayman foundation + DE C-corp for the token entity, per counsel">
---

# /remember

Commit a decision or durable fact to memory so future sessions honor it. See
[`memory.md`](../skill/references/memory.md).

## Steps
1. Decide the tier ([`memory.md`](../skill/references/memory.md)):
   - **Consequential / gated / irreversible** (entity, jurisdiction, audit outcome, token params,
     custody model, mainnet deploy, incident) → write `.solana-brain/decisions/NNNN-slug.md` using the
     decision skeleton, then add a one-line pointer in `.solana-brain/MEMORY.md` and update the matching
     `.solana-brain/profile.md` field.
   - **State change only** → update the **Current state** / **Open threads** sections of `MEMORY.md`.
2. Use the real date (`current date is 2026-06-29`). Set status: `proposed · decided · done · superseded`.
3. If this reverses a prior decision, mark the old record `superseded by [[NNNN]]` — never delete it.
4. Record the *decision and its one-line why*, with a link to the artifact. Do not restate the prompt.

## Output
- The path written and a one-line confirmation of what's now remembered.
- Key-safe: store public keys/addresses/program IDs and rationale — **never** a private key or seed.
