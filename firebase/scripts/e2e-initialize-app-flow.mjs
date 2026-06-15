/**
 * Mirrors the Flutter app's initializeFamilyVault() cloud path.
 * Run: node scripts/e2e-initialize-app-flow.mjs
 */
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const API_KEY = 'AIzaSyBHA76SBA_gM4mPNgOTlRjpeW_f8QZhyxE';
const PROJECT_ID = 'anchorly-da184';
const HOSTING_URL = 'https://anchorly-da184.web.app';

const root = dirname(fileURLToPath(import.meta.url));
const initDart = readFileSync(
  join(root, '..', '..', 'lib', 'custom_code', 'actions', 'initialize_family_vault.dart'),
  'utf8',
);

let failed = 0;
const log = (ok, msg) => {
  console.log(`${ok ? '✅' : '❌'} ${msg}`);
  if (!ok) failed++;
};

console.log('E2E: Flutter initializeFamilyVault cloud path\n');

// 1) Hosted build is live
try {
  const res = await fetch(HOSTING_URL, { redirect: 'follow' });
  const html = await res.text();
  log(res.ok, `Hosting ${HOSTING_URL} responds HTTP ${res.status}`);
  log(html.includes('flutter'), 'Hosted page contains Flutter bootstrap');
  log(
    initDart.includes('cloudSynced = true'),
    'Local initialize_family_vault.dart has cloud sync path',
  );
} catch (e) {
  log(false, `Hosting check: ${e.message}`);
}

// 2) Anonymous auth (ensureAnonymousAuth / _signInForInitialize)
let uid, idToken;
try {
  const res = await fetch(
    `https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ returnSecureToken: true }),
    },
  );
  const body = await res.json();
  if (!res.ok) throw new Error(body?.error?.message ?? JSON.stringify(body));
  uid = body.localId;
  idToken = body.idToken;
  log(true, `Anonymous sign-in uid=${uid}`);
} catch (e) {
  log(false, `Anonymous sign-in: ${e.message}`);
  process.exit(1);
}

function fields(obj) {
  const out = {};
  for (const [k, v] of Object.entries(obj)) {
    if (typeof v === 'string') out[k] = { stringValue: v };
    else if (typeof v === 'boolean') out[k] = { booleanValue: v };
  }
  return out;
}

async function firestorePost(collection, data, documentId) {
  const base = `https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents/${collection}`;
  const url = documentId ? `${base}?documentId=${documentId}` : base;
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${idToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ fields: fields(data) }),
  });
  const body = await res.json();
  if (!res.ok) throw new Error(body?.error?.message ?? JSON.stringify(body));
  return body.name.split('/').pop();
}

async function firestorePatchUser(data) {
  const path = `projects/${PROJECT_ID}/databases/(default)/documents/users/${uid}`;
  const mask = Object.keys(data)
    .map((k) => `updateMask.fieldPaths=${k}`)
    .join('&');
  const res = await fetch(
    `https://firestore.googleapis.com/v1/${path}?${mask}`,
    {
      method: 'PATCH',
      headers: {
        Authorization: `Bearer ${idToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ fields: fields(data) }),
    },
  );
  const body = await res.json();
  if (!res.ok) throw new Error(body?.error?.message ?? JSON.stringify(body));
  return body;
}

// 3) initializeFamilyVault writes (same order as Dart)
let familyId;
try {
  familyId = await firestorePost('family_groups', {
    groupName: 'My Family',
    multiAdultApproval: true,
    auditAccess: true,
    signatureSharing: true,
  });
  log(true, `family_groups created id=${familyId}`);
} catch (e) {
  log(false, `family_groups: ${e.message}`);
}

try {
  await firestorePatchUser({
    familyId,
    role: 'Adult',
    name: 'Family Admin',
    initials: 'FA',
    status: 'active',
  });
  log(true, `users/${uid} written familyId=${familyId}`);
} catch (e) {
  log(false, `users doc: ${e.message}`);
}

try {
  await firestorePost('audit_logs', {
    actionType: 'VAULT_INITIALIZED',
    actorName: 'Family Admin',
    timestamp: new Date().toISOString(),
    detailIcon: 'shield',
    detailText: 'Family vault initialized',
    familyId,
  });
  log(true, 'audit_logs created');
} catch (e) {
  log(false, `audit_logs: ${e.message}`);
}

// 4) Post-init reads (dashboard / member management queries)
try {
  const q = encodeURIComponent(
    JSON.stringify({
      structuredQuery: {
        from: [{ collectionId: 'users' }],
        where: {
          fieldFilter: {
            field: { fieldPath: 'familyId' },
            op: 'EQUAL',
            value: { stringValue: familyId },
          },
        },
      },
    }),
  );
  const res = await fetch(
    `https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents:runQuery`,
    {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${idToken}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        structuredQuery: {
          from: [{ collectionId: 'users' }],
          where: {
            fieldFilter: {
              field: { fieldPath: 'familyId' },
              op: 'EQUAL',
              value: { stringValue: familyId },
            },
          },
        },
      }),
    },
  );
  const rows = await res.json();
  if (!res.ok) throw new Error(JSON.stringify(rows));
  const count = rows.filter((r) => r.document).length;
  log(count >= 1, `Family-scoped users query returned ${count} member(s)`);
} catch (e) {
  log(false, `users query: ${e.message}`);
}

console.log(
  failed === 0
    ? '\n🎉 E2E passed — cloud Initialize path matches live Firebase + rules.'
    : `\n⚠️  E2E finished with ${failed} failure(s).`,
);
process.exit(failed === 0 ? 0 : 1);