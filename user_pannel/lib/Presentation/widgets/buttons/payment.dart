import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:trendychef/core/constants/colors.dart';

SwipeButton paymentSwipeButton(BuildContext context) {
  return SwipeButton(
    activeTrackColor: Colors.white,
    activeThumbColor: AppColors.primary,
    borderRadius: BorderRadius.circular(10),
    height: 50,
    child: Text("Swipe to ... Payment", style: TextStyle(color: Colors.black)),
    onSwipe: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Swipped"), backgroundColor: Colors.green),
      );
    },
  );
}
