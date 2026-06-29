---
description: Universal entry to solana-brain — describe any Solana company task or goal and it classifies, routes to the right cluster(s), and sequences the work.
argument-hint: <anything: "build X", "ship to mainnet", "is this safe", "launch a token", "incorporate", "what's next">
---

# /brain

The front door. Use when you're not sure which cluster owns a request.

## Steps
1. Invoke **chief-of-staff**.
2. Intake + infer lifecycle stage ([`company-lifecycle.md`](../skill/references/company-lifecycle.md)).
3. Classify via [`RESOLVER.md`](../skill/RESOLVER.md) → name the cluster(s).
4. If a single task → route to that cluster file + lead. If a goal → use [`orchestration.md`](../skill/references/orchestration.md) and sequence with gates.
5. Delegate depth to specialist skills ([`ecosystem-map.md`](../skill/references/ecosystem-map.md)).

## Output
- The matched cluster(s) + why, the entry file(s)/agent, and — for goals — the sequenced plan with gates.
- Then proceed (or hand to the right cluster command). "Current as of 2026-06."
