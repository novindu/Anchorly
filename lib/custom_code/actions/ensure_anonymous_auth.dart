import 'package:firebase_auth/firebase_auth.dart';

import '/auth/firebase_auth/anonymous_auth.dart';
import '/custom_code/actions/initialize_family_vault.dart';
import '/flutter_flow/nav/nav.dart';

/// Ensures a Firebase Auth session exists (anonymous for beta bootstrap).
/// Suppresses router refresh during sign-in so onboarding can finish setup.
Future<User> ensureAnonymousAuth() async {
  final existing = FirebaseAuth.instance.currentUser;
  if (existing != null) {
    return existing;
  }

  AppStateNotifier.instance.updateNotifyOnAuthChange(false);
  try {
    final cred = await anonymousSignInFunc();
    final user = cred?.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'configuration-not-found',
        message:
            'Firebase Authentication is not configured. Open Firebase Console → Authentication → Get started, then enable Anonymous.',
      );
    }
    return user;
  } on FirebaseAuthException catch (e) {
    if (isFirebaseAuthNotConfigured(e)) {
      throw FirebaseAuthException(
        code: e.code,
        message:
            'Firebase Authentication is not configured on anchorly-da184. '
            'One-time setup: https://console.firebase.google.com/project/anchorly-da184/authentication '
            '(click Get started → enable Anonymous).',
      );
    }
    rethrow;
  } finally {
    AppStateNotifier.instance.updateNotifyOnAuthChange(true);
  }
}