import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';

Widget buildTabButton(
  String text,
  int index,
  int currentIndex,
  Function(int) onTabPressed,
) {
  final isSelected = currentIndex == index;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    child: GestureDetector(
      onTap: () => onTabPressed(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.8),
                      AppColors.primary.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: isSelected ? null : AppColors.secondary,
          borderRadius: BorderRadius.circular(25),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: const Color(0xFF667eea).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          border: Border.all(
            color:
                isSelected ? Colors.transparent : Colors.white.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isSelected ? AppColors.fontWhite : AppColors.fontBlack,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: isSelected ? 15 : 14,
          ),
          child: Text(text),
        ),
      ),
    ),
  );
}

Row tabButton(int currentIndex, Function(int) onTabPressed) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(child: buildTabButton("Dash", 0, currentIndex, onTabPressed)),
      const SizedBox(width: 8),
      Expanded(child: buildTabButton("Orders", 1, currentIndex, onTabPressed)),
      const SizedBox(width: 8),
      Expanded(
        child: buildTabButton("Wishlist", 2, currentIndex, onTabPressed),
      ),
    ],
  );
}
