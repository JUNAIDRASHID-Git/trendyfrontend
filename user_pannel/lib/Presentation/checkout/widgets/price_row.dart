import 'package:flutter/material.dart';

Widget buildPriceRow(String label, String amount, {bool isTotal = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Row(
          children: [
            Image.asset("assets/images/riyal_logo.png", width: 14, height: 14),
            Text(
              amount,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
