---
description: Incident-response runbook — SECURE (triage/contain/preserve) → SHIP (mitigate/restore) → OPERATE (disclosure). For exploits, drains, or outages.
argument-hint: [what's happening]
---

# /incident

Spans **SECURE → SHIP → OPERATE**. Speed matters; preserve evidence first. Read-only / key-safe.

## Steps
1. **SECURE** — triage scope + severity; **contain** (pause/upgrade if possible); **preserve evidence**; identify the vector (incl. drainer patterns). ([`secure.md`](../skill/clusters/secure.md))
2. **SHIP** — deploy mitigation, restore service, add detections/alerts. ([`ship.md`](../skill/clusters/ship.md))
3. **OPERATE** — user comms + disclosure timing + counsel/regulatory considerations + post-mortem. ([`operate.md`](../skill/clusters/operate.md))

## Output
- A live runbook: current status, containment actions, mitigation/restore steps, and a comms/disclosure plan (counsel-flagged).
- Do not skip evidence preservation. Capture a timeline for the post-mortem. "Current as of 2026-06."
