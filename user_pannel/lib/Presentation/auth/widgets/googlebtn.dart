import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

            // Create a Google Auth provider
            final googleProvider = GoogleAuthProvider();

            // Sign in using a popup (only supported on web)
            final userCredential = await auth.signInWithPopup(googleProvider);

            final user = userCredential.user;
            final idToken = await user?.getIdToken();

            if (idToken != null) {
              userGoogleAuthHandler(idToken, context);
            } else {
              print("❌ Failed to get ID token");
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
