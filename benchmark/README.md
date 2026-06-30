# Benchmark — solana-brain, with vs without

A reproducible A/B: the **same base model** answers hard Solana tasks twice — once with no skill
(control), once with solana-brain loaded (treatment) — and a **blind judge** scores the answers. Real
agents, real scores, no hand-tuning. Figures are averaged over **2 runs** to smooth single-judge variance.
Full numbers: [`results.json`](results.json).

## Headline (averaged over 2 runs)

| | Without skill | **With solana-brain** | Gap |
|---|---|---|---|
| **Answer quality** (overall) | 8.70 | **9.13** | wins **all 5 dimensions** |
| **Memory continuity** | 3.13 | **9.75** | **3.1× (+211%)** |

Quality is led by **actionability** (+1.0) and **completeness** (+0.6) — the skill produces denser, more
complete, more concrete answers. Memory continuity is a **categorical** win: a plain LLM has no
per-project memory, so it gives generic advice; the skill recalls and honors the project's actual prior
decisions every time.

## How we got here (the honest improve loop)

1. **v2** — capped one-shot Q&A → **parity, slightly behind**. An already-expert base model has little
   headroom, and the skill wasted answer space on visible routing chatter.
2. **Answer contract** — made the skill answer *substance-first* (route silently; complete across every
   cluster touched; concrete; gates inline) → **flipped to a quality win**.
3. **76-finding audit** → deepened the clusters with concrete, current specifics: the canonical
   tx-landing path (BUILD), the Solana invariant checklist (SECURE), 2026 stack + Codama, named SWQoS
   send products + `solana-verify` (SHIP), the Howey/MiCA/entity framework (OPERATE) → **wins every
   quality dimension**; memory stays 3.1×.

We publish the **per-run numbers and the variance** in [`results.json`](results.json), not a single
cherry-picked figure.

## Method

- Two answering agents (control / treatment), same base model; treatment reads the skill files and, for
  the memory set, a seeded `.solana-brain/`. Run via the Workflow harness.
- One blind judge scored identity-stripped A/B; quality on 5 dimensions, memory on objective continuity
  vs the known prior decisions.

## Caveats (we don't oversell)

- Single LLM judge; small N — directional. Run-to-run variance is real (control quality 8.35–9.05);
  the skill wins both axes in **every** run.
- Same elite base model both sides — quality gains are real but bounded; you can't out-IQ an expert on a
  one-shot answer. The skill's bigger, categorical edge is **memory continuity**.
- Set B is a **capability** comparison: a plain LLM structurally lacks project memory.

**Bottom line:** solana-brain wins on answer quality (all 5 dimensions) and is **3.1× better at
remembering your company's decisions** — the capability that compounds across sessions.
