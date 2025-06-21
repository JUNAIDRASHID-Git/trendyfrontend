import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/btn/cart_btn.dart';
import 'package:trendychef/core/constants/colors.dart';

Container priceContainer({
  required double salePrice,
  required double regularPrice,
  required String productID,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Price",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            color: AppColors.fontBlack.withOpacity(0.8),
          ),
        ),

        Row(
          children: [
            Image.asset("assets/images/riyal_logo.png", width: 28),
            SizedBox(width: 5),
            Text(
              "$salePrice",
              style: TextStyle(
                fontSize: 28,
                fontFamily: "Poppins",
                color: AppColors.fontBlack,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              "assets/images/riyal_logo.png",
              width: 20,
              color: AppColors.fontBlack.withOpacity(0.8),
            ),
            SizedBox(width: 5),
            Text(
              "$regularPrice",
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 20,
                fontFamily: "Poppins",
                color: AppColors.fontBlack.withOpacity(0.8),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        CartButton(productId: productID),
      ],
    ),
  );
}
