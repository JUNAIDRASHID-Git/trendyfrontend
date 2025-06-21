import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendychef/core/services/api/auth/auth.dart';

Container googleBtn(BuildContext context) {
  return Container(
    width: 270,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 1.5),
    ),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () async {
          try {
            final auth = FirebaseAuth.instance;

            if (kIsWeb) {
              // ✅ Web: Use signInWithPopup
              final googleProvider = GoogleAuthProvider();
              final userCredential = await auth.signInWithPopup(googleProvider);
              final idToken = await userCredential.user?.getIdToken();
              if (idToken != null) {
                userGoogleAuthHandler(idToken, context);
              } else {
                print("❌ Failed to get ID token");
              }
            } else {
              // ✅ Android/iOS/Desktop: Use google_sign_in package
              final GoogleSignInAccount? googleUser =
                  await GoogleSignIn().signIn();

              if (googleUser == null) {
                print("❌ Sign-in aborted by user");
                return;
              }

              final GoogleSignInAuthentication googleAuth =
                  await googleUser.authentication;

              final credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken,
              );

              final userCredential = await auth.signInWithCredential(
                credential,
              );
              final idToken = await userCredential.user?.getIdToken();

              if (idToken != null) {
                userGoogleAuthHandler(idToken, context);
              } else {
                print("❌ Failed to get ID token");
              }
            }
          } catch (e) {
            print("❌ Google sign-in error: $e");
          }
        },
        borderRadius: BorderRadius.circular(30),
        splashColor: const Color.fromARGB(255, 110, 168, 128),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset("assets/images/google_logo.png"),
              ),
              const Text(
                "Sign in with Google",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
