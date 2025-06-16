import 'package:flutter/material.dart';

Widget buildPageIndicators(int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(3, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 8,
        width: currentIndex == index ? 24 : 8,
        decoration: BoxDecoration(
          gradient:
              currentIndex == index
                  ? const LinearGradient(
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  )
                  : null,
          color: currentIndex == index ? null : Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }),
  );
}
