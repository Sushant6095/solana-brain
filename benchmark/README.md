# Benchmark — solana-brain, with vs without

A reproducible A/B: the **same base model** answers hard Solana questions twice — once with no skill
(control), once with solana-brain loaded (treatment) — and a **blind judge** scores the answers. Real
agents, real scores, no hand-tuning. Everything here is the actual output.

## Honesty first

We ran two rounds and we're publishing both, including the one where the skill didn't win:

- **v1 ([questions.md](questions.md))** — one-shot factual Q&A, capped at ~200 words. **Result: parity,
  slightly favoring the control** (overall **8.47** vs **8.20**). Why: the base model (an already-expert
  LLM) has almost no headroom on raw recall, and the word cap punished the skill's routing structure.
  The skill edged the control only on *gate-awareness* — its design goal. A fair finding, but a poor
  test of what the skill is for. Raw answers in [answers-control.md](answers-control.md) /
  [answers-treatment.md](answers-treatment.md).
- **v2 ([questions-v2.md](questions-v2.md))** — fixes the test: **uncapped**, and aimed at what the skill
  actually does. This is the real result below.

## v2 results ([results-v2.json](results-v2.json))

### Set A — answer quality under pressure (4 tasks, 5 dimensions)

| | Correctness | Completeness | Gate-discipline | Actionability | Safety | **Overall** |
|---|---|---|---|---|---|---|
| without skill | 9.0 | 8.75 | 8.75 | 8.25 | 9.0 | **8.75** |
| with skill | 9.0 | 8.25 | 8.75 | 7.75 | 9.0 | **8.55** |

**Parity.** Same elite base model both sides → little headroom. Both refuse to skip gates under
"launch by Friday / deploy tonight" pressure; both are excellent. The skill does **not** add raw
knowledge, and we don't claim it does.

### Set B — memory continuity (2 tasks)

| | Continuity (0–10) |
|---|---|
| without skill | **3.5** |
| with skill | **9.0** |

**Categorical win (+157%, 2.6×).** Inside a project with established prior decisions (Anchor · OtterSec
audit-before-mainnet · Squads 3-of-5 · Helius · Cayman+DE), the follow-up tasks ask what to do next.
Without solana-brain the model has **no per-project memory** — it gives generic best-practice that
doesn't reference the actual decisions. With it, the model **recalls and honors them**, and refuses to
contradict a settled one (e.g. rejects "use a single hot wallet as upgrade authority" by citing the
recorded Squads 3-of-5 decision). This is the skill's core value, and it's where the gap is real.

## Method

- Two answering agents (control / treatment), same base model; treatment read the skill files and, for
  Set B, a seeded `.solana-brain/` memory. Answers in `answers-*-v2.md`.
- One blind judge scored identity-stripped copies (`Assistant A` = control, `Assistant B` = treatment).
- Set A: 5 dimensions; Set B: objective continuity vs the known decisions.

## Caveats (don't oversell)

- Single LLM judge; small N (4 + 2 tasks) — directional, not a paper.
- Same expert base model both sides, so Set A has little headroom *by design*.
- Set B is a **capability** test: a plain LLM structurally lacks project memory. That gap is the point
  of the feature, not a trick — but it's a capability comparison, not a like-for-like quality delta.
- Set A used fixed slots (A=control) with identity hidden from the judge; not slot-alternated.

**Bottom line:** solana-brain matches an already-expert model on one-shot answers and **transforms it on
continuity** — remembering and honoring your project's decisions across sessions. That compounding
memory is the install benefit.
