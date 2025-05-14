import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/auth/auth_api.dart';

Container googleBtn(BuildContext context) {
  return Container(
    width: 270,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(width: 1.5),
    ),
    child: Material(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          googleSignHandler(context);
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
                  color: Color.fromARGB(255, 0, 0, 0),
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
