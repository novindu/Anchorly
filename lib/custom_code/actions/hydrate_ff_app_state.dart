import 'package:cloud_firestore/cloud_firestore.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/app_state.dart';

/// Loads activeFamilyId + currentUserRole from the signed-in user's Firestore doc.
Future<void> hydrateFFAppStateFromUserDoc() async {
  if (!loggedIn || currentUserUid.isEmpty) {
    return;
  }

  try {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .get();

    if (!snap.exists) {
      return;
    }

    final data = snap.data();
    if (data == null) {
      return;
    }

    final familyId = data['familyId'] as String?;
    final role = data['role'] as String?;

    if (familyId != null && familyId.isNotEmpty) {
      FFAppState().activeFamilyId = familyId;
    }
    if (role != null && role.isNotEmpty) {
      FFAppState().currentUserRole = role;
    }
  } catch (_) {
    // Hydration is best-effort; UI surfaces Firestore errors elsewhere.
  }
}