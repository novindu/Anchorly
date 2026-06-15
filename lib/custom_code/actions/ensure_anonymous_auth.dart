import 'package:firebase_auth/firebase_auth.dart';

import '/auth/firebase_auth/anonymous_auth.dart';
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
      throw Exception(
        'Anonymous sign-in failed. In Firebase Console enable Authentication → Sign-in method → Anonymous.',
      );
    }
    return user;
  } finally {
    AppStateNotifier.instance.updateNotifyOnAuthChange(true);
  }
}