import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/btn/cart_btn.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/data/models/product.dart';

Padding productCard(BuildContext context, ProductModel product) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: SizedBox(
      width: 155,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                opacity: 0.2,
                image: AssetImage(
                  "assets/images/bg.png",
                ), // Your background image
                fit: BoxFit.cover,
              ),
              color: AppColors.fontWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                40,
              ), // add bottom padding to avoid overlap with button
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product image and weight badge
                  Center(
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child:
                          product.image != ""
                              ? Image.network(
                                product.image,
                                fit: BoxFit.fitHeight,
                              )
                              : Image.asset("assets/images/trendy_logo.png"),
                    ),
                  ),

                  /// Spacer pushes name and price to bottom
                  const Spacer(),

                  /// Product name
                  Text(
                    product.eName.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: "Poppins",
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Prices
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.salePrice.toString()} SAR",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (product.regularPrice != 0)
                              Text(
                                product.regularPrice.toString(),
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: Text(
                              "${product.weight} kg",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Positioned CartButton overlapping bottom center
          Positioned(
            bottom: -20, // half of button height to overflow
            left: 0,
            right: 0,
            child: Center(child: CartButton(productId: "${product.id}")),
          ),
        ],
      ),
    ),
  );
}
