import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/Presentation/checkout/widgets/price_row.dart';

Container checkOutPriceDetailsRow(CheckOutLoaded state) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Coupon Field
        TextField(
          decoration: InputDecoration(
            hintText: "Coupon Code",
            prefixIcon: Icon(Icons.local_offer, size: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),

        SizedBox(height: 16),

        // Price Details
        buildPriceRow("Subtotal", "${state.totalAmount} SAR"),
        buildPriceRow("Shipping", "${state.shippingCost} SAR"),
        Divider(height: 16),
        buildPriceRow(
          "Total Incl. VAT",
          "${state.shippingCost + state.totalAmount} SAR",
          isTotal: true,
        ),
      ],
    ),
  );
}
