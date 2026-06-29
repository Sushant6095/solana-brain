#!/usr/bin/env node
// solana-brain — npm entry point.
// Thin, dependency-free wrapper that runs the bundled install.sh (the real engine).
// `npx solana-brain` or a global install exposes the `solana-brain` command; all flags
// (--user, --project DIR, -y, --fast, --plain) pass straight through.
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { existsSync } from 'node:fs';

const pkgRoot = join(dirname(fileURLToPath(import.meta.url)), '..');
const installer = join(pkgRoot, 'install.sh');
const args = process.argv.slice(2);

if (!existsSync(installer)) {
  console.error(`solana-brain: install.sh not found in package (${pkgRoot}). Reinstall the package.`);
  process.exit(1);
}

const launch = (cmd) =>
  spawnSync(cmd, [installer, ...args], { stdio: 'inherit', cwd: process.cwd() });

let res;
if (process.platform === 'win32') {
  // install.sh is a bash script — needs Git Bash or WSL on Windows.
  res = launch('bash');
  if (res.error) {
    console.error(
      'solana-brain requires bash. On Windows, install Git Bash (https://git-scm.com) or use WSL,\n' +
      'then re-run:  npx solana-brain'
    );
    process.exit(1);
  }
} else {
  res = launch('bash');
  if (res.error) {
    console.error(`solana-brain: could not launch bash — ${res.error.message}`);
    process.exit(1);
  }
}

process.exit(res.status == null ? 1 : res.status);
