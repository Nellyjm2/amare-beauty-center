import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA0_KgV66AguF69veRvf6b-RfoGQWrLg-M",
            authDomain: "beauty-salon-amare-uiy3r6.firebaseapp.com",
            projectId: "beauty-salon-amare-uiy3r6",
            storageBucket: "beauty-salon-amare-uiy3r6.firebasestorage.app",
            messagingSenderId: "217673991832",
            appId: "1:217673991832:web:96b8734a257623f059b2ed",
            measurementId: "G-KCN18ECD7F"));
  } else {
    await Firebase.initializeApp();
  }
}
