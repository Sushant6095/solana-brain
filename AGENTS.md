# AGENTS.md — solana-brain

Entry point for Codex and other agents (mirrors `CLAUDE.md`).

**solana-brain** is one skill that routes across five clusters to build and operate a Solana
company: **BUILD, SHIP, SECURE, GROW, OPERATE**.

## Use it brain-first

For any Solana task:
0. Recall memory — read `.solana-brain/MEMORY.md` (`skill/references/memory.md`); honor prior decisions.
1. Classify with `skill/RESOLVER.md` → which cluster(s)?
2. Open the matching `skill/clusters/<cluster>.md` (multi-cluster goal → `skill/references/orchestration.md`).
3. Delegate depth to the specialist skill it names (`skill/references/ecosystem-map.md`) — don't reinvent.
4. Respect gates: SECURE before SHIP/GROW; OPERATE (legal/tax) before a token launch.
5. Verify with the cluster's check.
6. Record what changed — update `.solana-brain/MEMORY.md`; write a decision record for big calls (`/remember`).

## Non-negotiables

- Read-only / key-safe: never request/use a private key; the wallet signs; no auto-send.
- Memory is key-safe too: store public data, decisions, and rationale — never a private key or seed.
- OPERATE output is informational only (cite + flag counsel/CPA).
- Default to the 2026 stack; pin "current as of 2026-06"; verify fast-moving specifics.

Full detail: `skill/SKILL.md`. License: MIT.
