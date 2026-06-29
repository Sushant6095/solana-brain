---
name: safety-and-keys
description: Read-only / key-safe defaults across every cluster — no private keys, the wallet signs, no auto-send, secrets in env, informational-only for legal/tax.
globs:
  - "**/*.md"
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.rs"
---

# Safety & Keys

Binds every cluster and every route.

## 1. Never touch private keys
- Never request, store, log, or embed a **private key or seed phrase**. The wallet (adapter / MWA /
  multisig) signs. If offered a key, refuse and explain only a public address is needed.
- No **auto-send** or **auto-move** of funds without explicit human action per transaction.

## 2. Custody behind multisig
- Upgrade authority and treasury keys go behind a **multisig** (e.g. Squads), least privilege,
  signers isolated from any autonomous agent.

## 3. Secrets stay out of the repo
- RPC/provider/API keys live in env vars / secret managers — never in client bundles, the repo, or logs.

## 4. Security is a gate
- No mainnet value without an audit + custody plan. Never declare a transaction "safe" on a clean
  simulation alone (anti-sim / TOCTOU).

## 5. Informational-only for OPERATE
- Legal/tax/compliance output is **not advice**; cite the statute/standard and flag counsel/CPA
  before acting. No filings, opinions, or money movement.

## 6. Current + honest
- Default to the 2026 stack; no deprecated APIs or stale endpoints. Pin "current as of 2026-06" and
  verify time-sensitive specifics against primary docs.

---

*Read-only / key-safe is the default for the whole brain. Escalate to a human for anything that signs or moves value.*
