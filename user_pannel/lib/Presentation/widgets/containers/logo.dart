import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';

Container logoContainer() {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Image.asset(
          'assets/images/trendy_logo.png', // Replace with your logo path
          height: 40,
          width: 40,
          color: AppColors.fontWhite,
          // If you want to tint the logo
        ),
        SizedBox(width: 5),
        Text(
          "Trendy Chef",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.fontWhite,
            fontFamily: "logofont",
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
