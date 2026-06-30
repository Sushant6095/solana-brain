---
description: Capture or review the project's evidence-grounded learnings so the brain gets sharper every prompt — without hallucinating. Records a cited learning, promotes a hypothesis that now has new evidence, or supersedes one that's contradicted. No evidence, no entry.
argument-hint: "[the learning to capture — must cite an artifact; blank = review/promote recent learnings]"
---

# /evolve  ·  grounded self-improvement

Make the next prompt smarter than this one — strictly from observed reality. Protocol:
[`self-evolve.md`](../skill/references/self-evolve.md).

## Steps
1. **Capture (with an argument).** Only if it cites a concrete artifact from this project — an error,
   tx signature, test/benchmark result + command, PR, `file:line`, or a dated primary-doc link.
   **No evidence → refuse, and say what's missing.** Append to `.solana-brain/learnings.md` (newest on
   top) with `id · date · cluster · status` and **Learning / Evidence / Apply / Supersedes**.
2. **Status.** New observation → `hypothesis`. A definitive outcome or a second independent observation
   → `confirmed`. Contradicted by new evidence → mark the old one `superseded by [[L####]]`, never delete.
3. **Review (no argument).** List recent learnings; promote any `hypothesis` that now has a second data
   point; flag any that are stale (time-pinned and aged out) or contradicted.
4. Keep it **project-scoped** — a local observation is evidence about *this repo*, not a universal truth.

## Output
- The learning written (or the refusal + the evidence that's missing), and any promotions/supersessions.
- Key-safe: artifacts, addresses, and rationale only — never a private key. Hypotheses stay flagged
  until evidence confirms them.
