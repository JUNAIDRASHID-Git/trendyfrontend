import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/Presentation/auth/pages/auth.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  // Redirect to login screen
  Navigator.pushReplacement(
    // ignore: use_build_context_synchronously
    context,
    MaterialPageRoute(builder: (context) => AuthPage()),
  );
}
