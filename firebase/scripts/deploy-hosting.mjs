import { spawnSync } from 'node:child_process';
import { cpSync, existsSync, rmSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const root = dirname(fileURLToPath(import.meta.url));
const firebaseDir = join(root, '..');
const webBuildDir = join(firebaseDir, '..', 'build', 'web');
const hostingDistDir = join(firebaseDir, 'hosting-dist');
const firebaseBin = join(
  firebaseDir,
  'node_modules',
  'firebase-tools',
  'lib',
  'bin',
  'firebase.js',
);

if (!existsSync(webBuildDir)) {
  console.error(
    'Web build not found. Run from app/: flutter build web --release --no-tree-shake-icons',
  );
  process.exit(1);
}

if (existsSync(hostingDistDir)) {
  rmSync(hostingDistDir, { recursive: true, force: true });
}
cpSync(webBuildDir, hostingDistDir, { recursive: true });
console.log(`Copied web build to ${hostingDistDir}`);

const serviceAccountPath =
  process.env.GOOGLE_APPLICATION_CREDENTIALS ??
  join(firebaseDir, 'service-account.json');

const env = {
  ...process.env,
  GOOGLE_APPLICATION_CREDENTIALS: serviceAccountPath,
};

const result = spawnSync(
  process.execPath,
  [firebaseBin, 'deploy', '--only', 'hosting', '--project', 'anchorly-da184'],
  { cwd: firebaseDir, env, stdio: 'inherit' },
);

if (result.status !== 0) {
  process.exit(result.status ?? 1);
}

console.log('Hosting deploy complete: https://anchorly-da184.web.app');