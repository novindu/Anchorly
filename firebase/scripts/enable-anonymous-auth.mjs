/**
 * Enable Anonymous sign-in on anchorly-da184 via Identity Toolkit Admin API.
 * Run: node scripts/enable-anonymous-auth.mjs
 */
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { GoogleAuth } from 'google-auth-library';

const root = dirname(fileURLToPath(import.meta.url));
const firebaseDir = join(root, '..');
const serviceAccountPath =
  process.env.GOOGLE_APPLICATION_CREDENTIALS ??
  join(firebaseDir, 'service-account.json');

const serviceAccount = JSON.parse(readFileSync(serviceAccountPath, 'utf8'));
const projectId = serviceAccount.project_id;

const auth = new GoogleAuth({
  credentials: serviceAccount,
  scopes: [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/identitytoolkit',
  ],
});

const client = await auth.getClient();
const base = `https://identitytoolkit.googleapis.com/admin/v2/projects/${projectId}`;

async function request(method, url, body) {
  const res = await client.request({ method, url, data: body });
  return res.data;
}

console.log(`Enabling Anonymous auth for project: ${projectId}\n`);

let config;
try {
  config = await request('GET', `${base}/config`);
  console.log('Current config fetched.');
  console.log(
    'Anonymous enabled:',
    config?.signIn?.anonymous?.enabled ?? '(not set)',
  );
} catch (error) {
  console.log(
    'GET config failed (may need initial config):',
    error?.response?.data?.error?.message ?? error.message,
  );
}

try {
  const updated = await request('PATCH', `${base}/config?updateMask=signIn.anonymous.enabled`, {
    name: `${base}/config`,
    signIn: {
      anonymous: {
        enabled: true,
      },
    },
  });
  console.log('\n✅ Anonymous auth enabled.');
  console.log('Anonymous enabled:', updated?.signIn?.anonymous?.enabled);
} catch (error) {
  const msg = error?.response?.data?.error?.message ?? error.message;
  console.error('\n❌ PATCH failed:', msg);
  console.error(
    'Manual fallback: Firebase Console → Authentication → Sign-in method → Anonymous → Enable',
  );
  process.exit(1);
}