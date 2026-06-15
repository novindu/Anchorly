import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBHA76SBA_gM4mPNgOTlRjpeW_f8QZhyxE",
            authDomain: "anchorly-da184.firebaseapp.com",
            projectId: "anchorly-da184",
            storageBucket: "anchorly-da184.firebasestorage.app",
            messagingSenderId: "691786368396",
            appId: "1:691786368396:web:44820a360622e8563302a9",
            measurementId: "G-1HKRPQ9R5D"));
  } else {
    await Firebase.initializeApp();
  }
}
