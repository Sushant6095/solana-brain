# Answers — TREATMENT (solana-brain loaded)

Same base model, with solana-brain: the agent read SKILL.md / RESOLVER.md / orchestration.md / clusters and followed the brain protocol (recall → classify → route → sequence with gates → delegate → verify).

## Q1
**Classify: ALL clusters — orchestrate as the "Launch a token" playbook.** Sequence: BUILD → SECURE (gate) → OPERATE (gate) → GROW. A governance token is never "just GROW."

1. **BUILD** — mint/program design (Token-2022 extensions as needed), distribution + claim flow. Delegate to `solana-dev` / Anchor and `solana-client-layer` for a drainer-safe claim path.
2. **SECURE (hard gate)** — audit the mint/claim, custody of mint + upgrade authority behind a Squads multisig, drainer-reviewed claim UX. Delegate to `trailofbits` / `solana-client-layer`. No public claim until this passes.
3. **OPERATE (hard gate — the step teams skip and regret)** — this is dual-jurisdiction, so jurisdiction is explicit: **US** securities/Howey posture (governance tokens carry real classification risk) + **India** 30% VDA tax with 1% TDS on transfers and no loss set-off. Document both with counsel + CPA. Delegate to `crypto-legal` and `solana-accounting`. Informational only — flag counsel.
4. **GROW** — TGE plan, eligibility, comms, no price/return promises.

**"Next month" is the risk:** the SECURE and OPERATE gates, not GROW, set the timeline. If counsel/audit can't clear in time, the launch slips — I won't skip a gate to hit a date.

## Q2
**Classify: SECURE + SHIP — this is a live incident.** Run the Incident Response playbook via `/incident`: SECURE (triage/contain) → SHIP (mitigate/restore) → OPERATE (disclosure). Speed matters, but do **not** skip evidence preservation.

1. **SECURE — triage & contain first.** If the claim endpoint can be paused or the program upgraded to halt the drainer, do it now (upgrade authority via your multisig). Preserve evidence before changing anything: capture the malicious transactions, the signatures users approved, and the drainer pattern (unlimited `Approve`, `SetAuthority`, System `Assign` owner-reassignment, durable-nonce holds). Identify the vector. Delegate to `secure-lead` + `solana-client-layer` (tx-safety).
2. **SHIP — mitigate & restore.** Take down or gate the claim endpoint, deploy the fix, add detections/alerts so it can't silently recur.
3. **OPERATE — disclosure.** User comms, disclosure timing, counsel/regulatory considerations, post-mortem.

**Do not** tell users it's "safe" on a clean simulation — assume hostile inputs and anti-sim/TOCTOU. Key-safe throughout: the wallet signs; I touch no keys.

## Q3
**Classify: BUILD (client send path) — also touches SHIP (RPC infra).** This is the "txs won't land" path. Delegate depth to `solana-client-layer` (landing) and, for infra, `helius`/`quicknode`.

**Why it happens at peak:** at high traffic your transactions lose the fee market and expire. Common causes: priority fees too low for current congestion, compute-unit budget not set or mis-estimated, blockhash expiring before inclusion, no rebroadcast/confirm loop, and a shared read-RPC being used to send instead of a stake-weighted-QoS send endpoint.

**How to fix (BUILD):** set a compute-unit limit + a **dynamic** priority fee from live congestion data; consider Jito bundles for contested inclusion; use durable nonces where appropriate; add a rebroadcast-until-confirmed loop; measure land rate as a first-class metric.

**SHIP side:** use a dedicated SWQoS **send** path (separate from your read RPC and stream endpoints — often three different endpoints), and add a land-rate/slot-lag dashboard with alerts.

**Verify:** measured land rate under simulated peak load before calling it fixed.

## Q4
**Classify: "Ship to mainnet" orchestration — BUILD → SECURE (gate) → SHIP.** SECURE is a hard gate; two people doesn't waive it.

**BUILD (done before the gate):** feature-complete on devnet; program tests pass (LiteSVM/Mollusk); client send path lands + confirms; IDL/clients generated; tx-safety preview where users sign. Delegate to `build-lead`.

**SECURE (hard gate — do not deploy without passing):**
- Program audit / vuln review — delegate to `trailofbits` / `sendai` (vulnhunter). For a two-person team with no internal security depth, this gate matters *more*, not less.
- Custody plan: upgrade authority behind a **Squads multisig**, never a single hot key; least privilege; signers isolated from any agent.
- Findings resolved or explicitly risk-accepted by an owner.

**SHIP:**
- Reproducible mainnet deploy; upgrade authority multisig-controlled; secrets in a manager, not the bundle.
- Monitoring + alerts live (RPC health, land rate, error spikes); on-call path defined.
- **Rollback plan rehearsed** and an incident runbook (`/incident`) in place.

**Two-strike rule:** if any gate stalls twice, stop and surface it rather than skipping to hit "next week."

## Q5
**Classify: BUILD (program/account/PDA design) — touches SECURE.** This is on-chain logic; delegate depth to `solana-dev` / Anchor and pass the design through a SECURE review before mainnet value.

**Model:** give each depositor their own **user-position PDA**, derived from a stable seed set (e.g. `["position", vault, owner]`), holding their share/amount; a single **vault-state PDA** holds global accounting (total deposited, share supply); tokens sit in a vault-owned **token account / ATA** whose authority is a PDA, not a person. Use shares, not raw amounts, so deposits/withdrawals stay fair as the vault accrues.

**Pitfalls to design against:**
- **PDA seed collisions / missing canonical bump** — store and verify the canonical bump; never trust a user-supplied bump.
- **Account substitution** — validate every passed account's owner, the mint, and PDA derivation; assume hostile inputs.
- **Rounding / share inflation (first-depositor) attack** — seed initial liquidity or floor shares.
- **Rent + closing** — handle rent-exempt minimums and safe account closing (zeroing) to avoid revival.
- **Arithmetic** — checked math; no overflow on share conversion.

**Verify:** LiteSVM/Mollusk tests including adversarial cases, then the SECURE gate.

## Q6
**Classify: OPERATE — securities classification + entity formation; touches SECURE on custody.** Delegate to `crypto-legal` (jurisdiction/securities router) for classification and entity tradeoffs. **Informational only — not legal advice; engage counsel before acting.**

**Is it a security?** I can't and won't give a verdict — that's a counsel call under the **Howey** test (investment of money in a common enterprise with profit expected from others' efforts). What raises classification risk: marketing returns/price appreciation, pre-sale to investors, centralized roadmap-driven value. What lowers it: genuine present utility/governance, decentralized control, no profit messaging. This pairs with GROW discipline — no price/return promises in any comms.

**How to incorporate:** the standard tradeoffs `crypto-legal` routes are **Delaware C-corp** (US operating/fundraising, VC-friendly), **Cayman foundation** (common token-issuer wrapper, separates token from the operating company), and **Wyoming DAO LLC** (on-chain governance). The right structure depends on token plans and where your team/users sit — and yours span US + India, so jurisdiction must be explicit. This is a counsel decision; I'll prep the comparison, not file anything.

**Sequence note:** both questions are OPERATE gates that must clear *before* any token launch (see Q1).
