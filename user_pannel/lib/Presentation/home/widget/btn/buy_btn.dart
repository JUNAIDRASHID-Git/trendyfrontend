import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Container buyBtn(BuildContext context) {
  return Container(
    width: 100,
    height: 35,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: Material(
      color: deepGreen,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () async {
        },
        borderRadius: BorderRadius.circular(30),
        splashColor: const Color.fromARGB(255, 110, 168, 128),
        child: Center(
          child: const Text(
            "Buy Now",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}
