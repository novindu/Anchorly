import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '/app_state.dart';
import '/auth/firebase_auth/anonymous_auth.dart';
import '/backend/backend.dart';
import '/flutter_flow/nav/nav.dart';

class InitializeFamilyVaultResult {
  const InitializeFamilyVaultResult({
    required this.familyId,
    required this.familyGroupRef,
    required this.cloudSynced,
    this.notice,
  });

  final String familyId;
  final DocumentReference familyGroupRef;
  final bool cloudSynced;
  final String? notice;
}

bool isFirebaseAuthNotConfigured(Object error) {
  if (error is FirebaseAuthException) {
    final code = error.code.toLowerCase();
    if (code.contains('configuration-not-found') ||
        code == 'operation-not-allowed') {
      return true;
    }
  }
  final text = error.toString().toUpperCase();
  return text.contains('CONFIGURATION_NOT_FOUND');
}

Future<User> _signInForInitialize() async {
  final existing = FirebaseAuth.instance.currentUser;
  if (existing != null) {
    return existing;
  }
  final cred = await anonymousSignInFunc();
  final user = cred?.user;
  if (user == null) {
    throw FirebaseAuthException(
      code: 'configuration-not-found',
      message: 'Anonymous sign-in returned no user.',
    );
  }
  return user;
}

/// Creates a family vault locally (always) and syncs to Firestore when Auth is configured.
Future<InitializeFamilyVaultResult> initializeFamilyVault() async {
  final familyId = const Uuid().v4();
  final familyGroupRef = FamilyGroupsRecord.collection.doc(familyId);

  AppStateNotifier.instance.updateNotifyOnAuthChange(false);
  try {
    var cloudSynced = false;
    String? notice;

    try {
      final authUser = await _signInForInitialize();

      await familyGroupRef.set({
        'groupName': 'My Family',
        'multiAdultApproval': true,
        'auditAccess': true,
        'signatureSharing': true,
      });

      await UsersRecord.collection.doc(authUser.uid).set(
        createUsersRecordData(
          name: 'Family Admin',
          initials: 'FA',
          role: 'Adult',
          status: 'active',
          familyId: familyId,
        ),
        SetOptions(merge: true),
      );

      try {
        await AuditLogsRecord.collection.add({
          ...createAuditLogsRecordData(
            actionType: 'VAULT_INITIALIZED',
            actorName: 'Family Admin',
            timestamp: DateTime.now().toIso8601String(),
            detailIcon: 'shield',
            detailText: 'Family vault initialized',
          ),
          'familyId': familyId,
        });
      } catch (_) {
        // Audit is best-effort; do not block setup.
      }

      cloudSynced = true;
    } catch (e) {
      if (isFirebaseAuthNotConfigured(e)) {
        notice =
            'Local vault ready. Firebase Authentication is not enabled on this project yet — '
            'family data is on this device only until Auth is turned on in Firebase Console.';
      } else {
        rethrow;
      }
    }

    FFAppState().update(() {
      FFAppState().activeFamilyId = familyId;
      FFAppState().currentUserRole = 'Adult';
      FFAppState().cloudSyncActive = cloudSynced;
    });
    await FFAppState().persistState();

    return InitializeFamilyVaultResult(
      familyId: familyId,
      familyGroupRef: familyGroupRef,
      cloudSynced: cloudSynced,
      notice: notice,
    );
  } finally {
    AppStateNotifier.instance.updateNotifyOnAuthChange(true);
  }
}