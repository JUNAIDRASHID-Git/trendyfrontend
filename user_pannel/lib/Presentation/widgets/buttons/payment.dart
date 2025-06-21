import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:trendychef/Presentation/checkout/widgets/success_snackbar.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/api/user/order.dart';

SwipeButton paymentSwipeButton(BuildContext context, String userID) {
  return SwipeButton(
    activeTrackColor: AppColors.secondary,
    activeThumbColor: AppColors.primary,
    borderRadius: BorderRadius.circular(10),
    height: 50,
    child: Text("Swipe to ... Payment", style: TextStyle(color: Colors.black)),
    onSwipe: () {
      final paymentStatus = "paid";
      placeOrder(userID, paymentStatus);
      showCenterPopup(context);
    },
  );
}
