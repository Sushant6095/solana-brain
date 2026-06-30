---
title: Memory — the company's long-term brain
description: How solana-brain remembers. Recall before deciding; record after deciding. Institutional memory that persists across sessions so the brain never re-litigates a settled decision or forgets a gate it already cleared.
---

# Memory — the company's long-term brain

A chief-of-staff who forgets last week is useless. `solana-brain` keeps **institutional memory** for
the project: the decisions made, the gates cleared, the entity and stack chosen, the tokens launched,
the incidents survived — and *why*. Every session reads it before acting and writes to it after.

> **Recall before you route. Record after you verify.** Memory bookends the brain loop
> ([orchestration.md](orchestration.md)): `recall → classify → route → orchestrate → verify → record`.

> **Key-safe, always.** Memory stores public keys, program IDs, decisions, and rationale — **never** a
> private key or seed phrase. Treat every memory file as if it will be committed and read by the whole
> team. See [`rules/safety-and-keys.md`](../../rules/safety-and-keys.md).

## Where memory lives

Project-scoped, tool-agnostic, and git-trackable — separate from the read-only skill in `.claude/`:

```
.solana-brain/
├── MEMORY.md            ← the index + current state. Recall reads this FIRST, every time.
├── profile.md           ← durable company facts (entity, jurisdictions, stack pins, token, custody)
├── learnings.md         ← evidence-grounded learnings the brain evolves (recall reads this too)
└── decisions/
      └── NNNN-slug.md    ← one ADR-style record per consequential / irreversible decision
```

`MEMORY.md` is the working memory: a skimmable snapshot a fresh session can read in under 30 seconds to
answer *"where are we, and what's already been decided?"* `profile.md` holds facts that change rarely.
`decisions/` is the permanent record — append-only, never rewritten. `learnings.md` is the **self-evolve**
log — cited, confidence-tracked learnings the brain recalls and applies so it gets sharper every prompt;
no evidence, no entry ([self-evolve.md](self-evolve.md)).

## Recall — before classifying

1. Read `.solana-brain/MEMORY.md`. If it doesn't exist yet, this is a fresh company — note that.
2. If the task touches a domain with a recorded fact or prior decision, open that decision record or
   the relevant `profile.md` field before routing.
3. **Honor prior decisions.** If new information genuinely overturns one, *supersede it explicitly*
   (see below) — never silently contradict settled work.
4. Surface the relevant memory to the user in one line ("Memory: you chose a Cayman foundation +
   Delaware C-corp on 2026-05-12 for the token entity") so the decision context is visible.

## Record — after verifying

Every routed task that changes state ends with a write. Two tiers:

- **Always** — append nothing if nothing changed; otherwise update the **Current state** and **Open
  threads** sections of `MEMORY.md` so the snapshot stays true.
- **For consequential, gated, or irreversible choices** — write a decision record in `decisions/`,
  add a one-line pointer to `MEMORY.md`, and update the matching `profile.md` field.

What counts as consequential (always gets a decision record):

| Cluster | Record when… |
|---|---|
| BUILD | program architecture chosen, account/PDA model frozen, a breaking client change |
| SHIP | mainnet deploy, RPC/infra provider chosen, an on-call/runbook decision |
| SECURE | audit commissioned / passed / failed, custody & multisig model set, incident + postmortem |
| GROW | token parameters (supply, vesting, launch venue), airdrop design, a raise term |
| OPERATE | entity & jurisdiction, treasury policy, a compliance/legal determination, key hires |

## Entry format — no slop

Memory is signal, not narration. Enforce:

- **Factual and dated.** Use the real date (`current date is 2026-06-29`). Convert "last week" to a date.
- **Specific.** Link the artifact: PR, audit report, tx signature, program ID, file path, counsel name.
- **No restating the prompt.** Record the *decision and its reason*, not the conversation.
- **One decision per record.** Status is one of `proposed · decided · done · superseded`.
- **Supersede, never delete.** A reversed decision gets `superseded by [[NNNN]]`; the old record stays.
- **No filler.** No "we carefully considered" — state the option chosen and the one-line why.

### Decision record skeleton (`decisions/NNNN-slug.md`)

```markdown
# NNNN — <short decision title>
- date: 2026-06-29
- cluster: OPERATE
- status: decided
- gates: SECURE ✓ (audit 2026-06-20) · OPERATE pending counsel sign-off

**Decision.** <the choice, in one sentence.>

**Why.** <the one-line rationale + the main alternative rejected.>

**Links.** <PR / report / address / counsel / file path.>

**Supersedes.** <[[NNNN]] or —>
```

## Recall triggers

Read memory unprompted when the user: resumes work ("where were we"), asks "did we decide X",
starts a gated flow (`/ship-it`, `/launch-token`, `/raise`, `/incident`), or proposes something that
may contradict a recorded decision. The `/recall` command surfaces it on demand; `/remember` writes it.

## Commands

| Command | Does |
|---|---|
| [`/recall`](../../commands/recall.md) | Surface relevant memory before acting (no arg → show the `MEMORY.md` snapshot + recent decisions). |
| [`/remember`](../../commands/remember.md) | Record a decision or durable fact (writes a decision record and updates `MEMORY.md`/`profile.md`). |

---

*Memory is per-project institutional knowledge, not the skill's program logic. Key-safe: public data,
decisions, and rationale only. Current as of 2026-06.*
