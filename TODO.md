# Roadmap

`solana-brain` stays a **router** — depth goes into specialist skills, not the brain.

## Near-term
- [ ] `solana-brain doctor` — verify install, list which specialist skills are present, flag gaps per cluster.
- [ ] Publish to npm + a Homebrew tap; fill `solana-brain.rb` url/sha256; wire the `aikit`-style short install URL.
- [ ] Per-cluster "what's installed vs delegated" detection so the brain knows when to act vs route.

## Clusters & playbooks
- [ ] More orchestration playbooks: migration/upgrade, audit-and-fix, liquidity bootstrapping, validator launch.
- [ ] Stage-aware checklists per lifecycle stage (idea → scale).
- [ ] Wire each cluster's delegation to detect installed specialist skills and version-check them.

## Ecosystem
- [ ] Keep `ecosystem-map.md` current as specialist skills move/rename.
- [ ] Optional adapters for the vertical skills (`solana-client-layer`, `crypto-legal`, `solana-accounting`).

## Verification
- [ ] Routing fixtures: sample requests → expected cluster(s) + plan, run in CI.
- [ ] Gate-enforcement tests (a token-launch plan must include SECURE + OPERATE gates).

## Watch list
See `skill/references/changelog-pinning.md`: delegated-skill availability, client stack, audit tooling,
tax/legal rules, token-launch norms.
