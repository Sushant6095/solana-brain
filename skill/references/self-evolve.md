---
title: Self-Evolve — get sharper every prompt, without hallucinating
description: How the brain improves over time by capturing evidence-grounded learnings into project memory. The skill's playbooks stay read-only; what evolves is per-project, cited, and confidence-tracked — never invented.
---

# Self-Evolve — compounding, grounded, no hallucination

The brain gets sharper after every prompt — but **only from observed reality**, never from the model's
imagination. Evolution does **not** mean rewriting the skill's own playbooks at runtime (that is
uncontrolled drift). It means accumulating **evidence-grounded learnings** in the project's memory
(`.solana-brain/learnings.md`) that the brain **recalls before acting** and **applies** next time.

> The loop closes: `… → verify → record → evolve → (next) recall`. Each verified task can leave one
> cited learning behind, so the next prompt starts smarter than the last.

## The one rule that prevents hallucination

**No evidence, no learning.** A learning may be written only if it cites a concrete artifact produced
in *this* project or session:

- an exact **error message** or compiler / Anchor output,
- a **transaction signature**, program ID, or explorer link,
- a **test / benchmark result** (with the command that produced it),
- a **PR / commit / `file:line`**,
- a **primary-doc URL** with the date it was checked.

If you cannot point to the artifact, you do not know it — **do not record it.** General knowledge the
model already carries is not a "learning" and must never be logged as one.

## Confidence ladder (promote on evidence, never on vibes)

| Status | Meaning | Influence |
|---|---|---|
| `hypothesis` | One observation; might be a fluke | Surfaced but flagged "unconfirmed" — never used to override a decision |
| `confirmed` | A definitive outcome, or ≥2 independent observations | Recalled and applied as guidance |
| `superseded` | Contradicted by newer evidence | Kept for history with `superseded by [[L####]]` |

Promotion requires a *new* piece of evidence — not repeating the same claim louder.

## Scope & safety

- **Project-scoped.** Learnings live in `.solana-brain/`, per repo. A local observation ("Helius webhook
  dropped events under burst load on 2026-06-14, see logs") is **project evidence, not a universal
  truth** — label it as such; never generalize one repo's data into a global claim.
- **The skill is read-only.** The agent never edits `skill/` playbooks at runtime. Evolution is *data in
  memory*, not mutation of program logic — so behavior stays bounded and auditable.
- **Key-safe.** Same as all memory: public data, rationale, and artifacts only — never a private key.
- **Supersede, never overwrite.** A wrong learning is superseded with the new evidence, not deleted.
- **Time-pinned.** Fast-moving facts carry "as of `<date>`" + a primary source; a learning can age out.

## Capture format (`.solana-brain/learnings.md`)

Append newest on top. One learning per entry:

```markdown
## L0007 · 2026-06-30 · SHIP · confirmed
**Learning.** A 50k µ-lamport/CU priority-fee floor was needed for >90% land rate on this program at peak.
**Evidence.** 3 runs, land rate 41%→94% after the bump — tx 5xY…, 9aP…, kQ…; bench in scripts/land-test.mjs.
**Apply.** When SHIP routes tx-landing for this repo, start at this floor; re-measure if program/IX size changes.
**Supersedes.** —
```

Fields: `id · date · cluster · status`, then **Learning / Evidence (required) / Apply / Supersedes**.

## When to capture

After a task is **verified**, ask: *did something actually change my model of how THIS project behaves?*
Capture only if yes, and only if cited. Good triggers:

- A fix that turned a red into a green — and *why* it worked.
- A gotcha that cost real time (the error + the resolution).
- A measured number (land rate, CU usage, account bytes, RPC latency, an audit finding).
- An approach that *demonstrably* failed here (with the failure artifact).

Do **not** capture: restated prompts, generic best practices, or anything you can't cite.

## Recall & apply

`recall` reads `learnings.md` alongside `MEMORY.md`. Before routing, surface any `confirmed` learning
that matches the task ("Learning L0007: this program needs a 50k priority-fee floor"). Apply confirmed
learnings; treat `hypothesis` ones as leads to verify, not facts.

Manual review: [`/evolve`](../../commands/evolve.md) lists recent learnings, promotes a hypothesis that
now has a second data point, and supersedes any contradicted by new evidence.

---

*Evolution = grounded institutional learning, not self-modification. Evidence or it didn't happen.
Key-safe. Current as of 2026-06.*
