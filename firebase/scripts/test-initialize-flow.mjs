/**
 * End-to-end simulation of Initialize Family Vault against live Firebase.
 * Run: node scripts/test-initialize-flow.mjs
 */
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';

const API_KEY = 'AIzaSyBHA76SBA_gM4mPNgOTlRjpeW_f8QZhyxE';
const PROJECT_ID = 'anchorly-da184';

const root = dirname(fileURLToPath(import.meta.url));
const rulesPath = join(root, '..', 'firestore.rules');
const rules = readFileSync(rulesPath, 'utf8');

function fail(step, error, extra = '') {
  console.error(`\n❌ FAIL at step: ${step}`);
  console.error(`   ${error}`);
  if (extra) console.error(`   ${extra}`);
  process.exit(1);
}

function ok(step, detail = '') {
  console.log(`✅ ${step}${detail ? ` — ${detail}` : ''}`);
}

async function signInAnonymously() {
  const res = await fetch(
    `https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${API_KEY}`,
    {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ returnSecureToken: true }),
    },
  );
  const body = await res.json();
  if (!res.ok) {
    const msg = body?.error?.message ?? JSON.stringify(body);
    if (msg === 'CONFIGURATION_NOT_FOUND') {
      console.error('\n⚠️  Firebase Authentication has never been activated on this project.');
      console.error('   One-time fix (project owner, ~2 minutes):');
      console.error('   https://console.firebase.google.com/project/anchorly-da184/authentication');
      console.error('   → Click "Get started" → Enable "Anonymous" sign-in → Save');
      console.error('\n   The app will run in local-only mode until this is done.');
      process.exit(2);
    }
    fail('anonymous sign-in', msg);
  }
  return { uid: body.localId, idToken: body.idToken };
}

function firestoreValue(fields) {
  const out = {};
  for (const [k, v] of Object.entries(fields)) {
    if (typeof v === 'string') out[k] = { stringValue: v };
    else if (typeof v === 'boolean') out[k] = { booleanValue: v };
  }
  return out;
}

async function firestoreCreate(collection, fields, idToken, documentId) {
  const base = `https://firestore.googleapis.com/v1/projects/${PROJECT_ID}/databases/(default)/documents/${collection}`;
  const url = documentId ? `${base}?documentId=${documentId}` : base;
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${idToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ fields: firestoreValue(fields) }),
  });
  const body = await res.json();
  if (!res.ok) {
    fail(
      `create ${collection}`,
      body?.error?.message ?? JSON.stringify(body),
      `HTTP ${res.status}`,
    );
  }
  const name = body.name ?? '';
  const id = name.split('/').pop();
  return { id, name, body };
}

async function firestorePatch(docPath, fields, idToken) {
  const url = `https://firestore.googleapis.com/v1/${docPath}?currentDocument.exists=true`;
  const fieldPaths = Object.keys(fields).map((k) => `updateMask.fieldPaths=${k}`).join('&');
  const res = await fetch(`${url}&${fieldPaths}`, {
    method: 'PATCH',
    headers: {
      Authorization: `Bearer ${idToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ fields: firestoreValue(fields) }),
  });
  const body = await res.json();
  if (!res.ok) {
    fail(`patch ${docPath}`, body?.error?.message ?? JSON.stringify(body));
  }
  return body;
}

async function firestoreSetUser(uid, fields, idToken) {
  const docPath = `projects/${PROJECT_ID}/databases/(default)/documents/users/${uid}`;
  // Try create first (new anonymous user)
  const createUrl = `https://firestore.googleapis.com/v1/${docPath}`;
  const createRes = await fetch(createUrl, {
    method: 'PATCH',
    headers: {
      Authorization: `Bearer ${idToken}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ fields: firestoreValue(fields) }),
  });
  const createBody = await createRes.json();
  if (createRes.ok) return createBody;

  // merge update if doc exists
  return firestorePatch(docPath, fields, idToken);
}

console.log('Anchorly Initialize Family Vault — live integration test\n');
console.log(`Project: ${PROJECT_ID}`);
console.log(`Rules file: ${rulesPath} (${rules.length} bytes)\n`);

const { uid, idToken } = await signInAnonymously();
ok('anonymous sign-in', `uid=${uid}`);

const family = await firestoreCreate(
  'family_groups',
  {
    groupName: 'Test Family',
    multiAdultApproval: true,
    auditAccess: true,
    signatureSharing: true,
  },
  idToken,
);
ok('create family_groups', `id=${family.id}`);

await firestoreSetUser(
  uid,
  {
    familyId: family.id,
    role: 'Adult',
    name: 'Family Admin',
    initials: 'FA',
    status: 'active',
  },
  idToken,
);
ok('write users doc', `familyId=${family.id}`);

await firestoreCreate(
  'audit_logs',
  {
    actionType: 'VAULT_INITIALIZED',
    actorName: 'Family Admin',
    timestamp: new Date().toISOString(),
    detailIcon: 'shield',
    detailText: 'Integration test vault initialized',
    familyId: family.id,
  },
  idToken,
);
ok('create audit_logs');

console.log('\n🎉 All Initialize steps succeeded against live Firebase + rules.');
console.log('If the app still fails, the bug is in Flutter (auth refresh, UI, or navigation).');