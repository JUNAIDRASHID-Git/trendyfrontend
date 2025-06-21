import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/data/models/order.dart';

Future<void> placeOrder(String userID, String paymentStatus) async {
  final uri = Uri.parse("$baseHost/orders/place");

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey, // Add this if your backend requires it
      },
      body: jsonEncode({
        "user_id": userID,
        "status": "pending",
        "payment_status": paymentStatus,
      }),
    );

    if (response.statusCode == 200) {
      log("Successfully placed order");
    } else {
      log("Failed to place order: ${response.statusCode} - ${response.body}");
      throw Exception('Failed to place order: ${response.statusCode}');
    }
  } catch (e) {
    log("Error placing order: $e");
    throw Exception("Error placing order: $e");
  }
}

Future<List<OrderModel>> fetchRecentOrder(String userID) async {
  final uri = Uri.parse("$baseHost/orders/user/$userID");

  try {
    // Use GET instead of POST if you are fetching data
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      log("Successfully fetched orders");

      // Parse response body as JSON list
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Map each json object to OrderModel
      return jsonList.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      log("Failed to fetch orders: ${response.statusCode}");
      throw Exception("Failed to fetch orders");
    }
  } catch (e) {
    log("Error fetching orders: $e");
    throw Exception(e.toString());
  }
}
