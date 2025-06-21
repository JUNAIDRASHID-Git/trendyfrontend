import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';

Stack productImageContainer({required String imageUrl, required double kg}) {
  return Stack(
    children: [
      // Background image
      Image.network(imageUrl),

      // Positioned label at top-right with 10px margin
      Positioned(
        top: 10,
        right: 10,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Text(
            "$kg kg",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ],
  );
}
