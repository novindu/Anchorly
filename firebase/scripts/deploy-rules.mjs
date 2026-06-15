import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import admin from 'firebase-admin';

const root = dirname(fileURLToPath(import.meta.url));
const firebaseDir = join(root, '..');
const serviceAccountPath =
  process.env.GOOGLE_APPLICATION_CREDENTIALS ??
  join(firebaseDir, 'service-account.json');

const serviceAccount = JSON.parse(readFileSync(serviceAccountPath, 'utf8'));
const rules = readFileSync(join(firebaseDir, 'firestore.rules'), 'utf8');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: serviceAccount.project_id,
});

try {
  const ruleset = await admin
    .securityRules()
    .releaseFirestoreRulesetFromSource(rules);
  console.log(`Published Firestore rules: ${ruleset.name}`);
} catch (error) {
  console.error('Deploy failed:', error?.message ?? error);
  process.exit(1);
}