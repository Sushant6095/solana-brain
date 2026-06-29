---
name: brain-first
description: Consult solana-brain (classify → route → verify) before ad-hoc action on any Solana task. This protocol is injected into the project's CLAUDE.md/AGENTS.md at install.
globs:
  - "**/*.md"
---

# Brain-First Protocol

When working in a repo where `solana-brain` is installed, **route through the brain before
improvising** on any Solana task.

## The protocol

0. **Recall** the project's memory first — read `.solana-brain/MEMORY.md` ([`../skill/references/memory.md`](../skill/references/memory.md)). Honor prior decisions; don't re-litigate a settled choice or re-clear a gate already passed.
1. **Classify** the request with [`../skill/RESOLVER.md`](../skill/RESOLVER.md) → which cluster(s)?
2. **Open** only that cluster file in [`../skill/clusters/`](../skill/clusters/); for a multi-cluster goal, use [`../skill/references/orchestration.md`](../skill/references/orchestration.md).
3. **Delegate** depth to the specialist skill the cluster names ([`../skill/references/ecosystem-map.md`](../skill/references/ecosystem-map.md)) — don't reinvent it.
4. **Respect gates** — SECURE before SHIP/GROW; OPERATE (legal/tax) before a token launch.
5. **Verify** with the cluster's check before calling the task done.
6. **Record** what changed — update `.solana-brain/MEMORY.md`, and for consequential/gated/irreversible choices write a decision record (`/remember`). No slop, key-safe.

## Why

The brain exists so cross-functional steps aren't skipped — the classic failure is shipping or
launching without the security and legal/tax gates. Routing first makes the whole company's
knowledge available on every task and keeps work in the right order.

## Don't

- Don't jump straight to code/launch without classifying.
- Don't duplicate a specialist skill's content into the repo; route to it.
- Don't skip a gate because the immediate ask didn't mention it.

---

*Installed brains append this protocol to the project's CLAUDE.md / AGENTS.md.*
