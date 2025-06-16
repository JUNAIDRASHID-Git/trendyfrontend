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
          filterQuality: FilterQuality.high,
          color: AppColors.primary,
          // If you want to tint the logo
        ),
        SizedBox(width: 5),
        Text(
          "Trendy Chef",
          style: TextStyle(
            fontSize: 20,
            color: AppColors.primary,
            fontFamily: "logofont",
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
