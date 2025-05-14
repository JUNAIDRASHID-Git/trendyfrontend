import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendychef/Presentation/auth/pages/auth.dart';
import 'package:trendychef/Presentation/home/home.dart';


class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check user login state after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));

      final isSignedIn = await GoogleSignIn().isSignedIn();

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => isSignedIn ?  HomePage() : const AuthPage(),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 233),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/trendy_logo.png",
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Color(0xFF02542D),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
