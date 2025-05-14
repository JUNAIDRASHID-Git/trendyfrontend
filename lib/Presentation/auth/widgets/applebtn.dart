import 'package:flutter/material.dart';

Container appleBtn() {
  return Container(
    width: 270,
    height: 60,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: Material(
      color: const Color.fromARGB(255, 32, 32, 32),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {
          // Call your sign-in function here
        },
        borderRadius: BorderRadius.circular(30),
        splashColor: const Color.fromARGB(255, 139, 139, 139),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset("assets/images/apple_logo.png"),
              ),
              const Text(
                "Sign in with Apple  ",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
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
