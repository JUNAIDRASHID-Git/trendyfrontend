import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/btn/buy_btn.dart';
import 'package:trendychef/Presentation/home/widget/btn/cart_btn.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/data/models/product.dart';
import 'package:trendychef/core/theme/colors.dart';

Padding productCard(BuildContext context, ProductModel product) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Container(
      width: 190,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greenShade,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Stack(
                alignment: Alignment(1.6, 1),
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      baseHost + product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      " ${product.weight} kg",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              textAlign: TextAlign.start,
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                fontFamily: "Poppins",
              ),
            ),
            Text(
              "${product.salePrice.toString()} SAR",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "265.00 SAR",
              style: TextStyle(decoration: TextDecoration.lineThrough),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buyBtn(context),
                SizedBox(height: 10),
                cartBtn(context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
