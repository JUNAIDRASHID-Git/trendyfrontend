import 'package:flutter/material.dart';

Container recentOrder() {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Orders",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        // Placeholder for recent orders list
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5, // Example count
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Order #${index + 1}"),
              subtitle: Text("Details of order #${index + 1}"),
            );
          },
        ),
      ],
    ),
  );
}
