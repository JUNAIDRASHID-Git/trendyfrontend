import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:trendychef/Presentation/home/home.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email'],
  serverClientId:
      "428220459878-nf80v2nj1fqkcs5h3ph51tuh2m2sh35n.apps.googleusercontent.com",
);

Future<void> googleSignHandler(BuildContext context) async {
  try {
    final account = await _googleSignIn.signIn();
    final auth = await account?.authentication;

    final idToken = auth?.idToken;
    if (idToken != null) {
      await sendToken(idToken,context);
    } else {
      print("ID token is null");
    }
  } catch (error) {
    print('Sign in failed: $error');
  }
}

Future<void> sendToken(String idToken,BuildContext context) async {
  final uri = Uri.parse("http://10.0.2.2:8080/auth/google");

  final response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"id_token": idToken}),
  );

  if (response.statusCode == 200) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
    print("User logged in");
  } else {
    print("Login failed: ${response.statusCode} ${response.body}");
  }
}

Future<void> googleLogout() async {
  try {
    await _googleSignIn.signOut();
    print("User logged out successfully");
  } catch (error) {
    print("Logout failed: $error");
  }
}
