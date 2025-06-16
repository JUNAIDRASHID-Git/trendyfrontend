import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/auth/logout.dart';

ElevatedButton logOutBtn(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      logout(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    child: const Text("Logout", style: TextStyle(color: Colors.white)),
  );
}
