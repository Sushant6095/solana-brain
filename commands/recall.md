---
description: Surface the project's institutional memory before acting — prior decisions, company profile, current state, and open threads. With no argument, shows the MEMORY.md snapshot.
argument-hint: "[topic — e.g. 'token entity', 'audit status', 'why Helius', or blank for the full snapshot]"
---

# /recall

Read the company's memory before deciding. Prevents re-litigating settled choices and skipping gates
already cleared. See [`memory.md`](../skill/references/memory.md).

## Steps
1. Read `.solana-brain/MEMORY.md`. If absent, say so — this is a fresh company; nothing recorded yet.
2. **With a topic** → open the matching decision record in `.solana-brain/decisions/` and the relevant
   `.solana-brain/profile.md` field; answer with the decision, date, status, and rationale.
3. **No topic** → summarize the snapshot: current state per active cluster, open threads, and the most
   recent decisions (newest first).
4. If the user is about to do something that contradicts a recorded decision, flag it and point to the
   record before proceeding.

## Output
- A skimmable answer grounded in what's recorded — quote dates, statuses, and links, not vibes.
- If memory is thin, name the gaps worth recording with `/remember`. Key-safe: never echo secrets.
