# Benchmark — hard Solana questions

Six realistic founder/engineer scenarios where the value of a *router + gates + completeness* shows.
Both conditions use the **same base model**; the only variable is whether solana-brain is loaded.

| # | Question | What a strong answer must not miss |
|---|---|---|
| Q1 | "We want to launch a governance token next month for US + India users. What do we need to do?" | SECURE audit gate **and** OPERATE legal/securities/tax (US + India) **and** GROW — sequenced, not just marketing |
| Q2 | "Our claim endpoint is draining wallets right now — what do we do?" | Incident order: contain → mitigate → restore → disclose; SECURE+SHIP+OPERATE, not just "patch the bug" |
| Q3 | "Our transactions keep failing to land at peak traffic. Why, and how do we fix it?" | Priority fees, CU budget, tx size, compute-unit price, retries/durable nonce, RPC choice — concrete |
| Q4 | "Two-person team, first program going to mainnet next week — readiness checklist?" | Audit gate, key custody/multisig, upgrade authority, monitoring, RPC, rollback — cross-cluster |
| Q5 | "Design the account/PDA model for a vault where many users deposit. Pitfalls?" | Per-user PDAs vs global account (Sealevel write contention), seeds/bump, rent, overflow, scale |
| Q6 | "Should our token be a security, and how do we incorporate?" | Informational-not-advice, flag counsel, jurisdiction tradeoffs (US/Cayman/etc.), honest uncertainty |

## Scoring rubric (0–10 per dimension, per answer)

- **correctness** — factually accurate and current to the 2026 Solana stack
- **completeness** — covers every area the scenario actually touches
- **gate_awareness** — flags the SECURE (audit/tx-safety) and OPERATE (legal/tax) gates *before* ship/launch when relevant
- **actionability** — concrete, sequenced next steps a team can execute
- **safety_honesty** — no hallucination, flags uncertainty, treats legal/tax as informational, key-safe

Overall = mean of the five dimensions. Judge scores **blind** (answers shown as A/B, not told which used the skill).
