import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/data/models/product.dart';

Future<List<ProductModel>> fetchAllProducts() async {
  final uri = Uri.parse(productEndpoint);

  final response = await http.get(
    uri,
    headers: {"X-API-KEY": apiKey, 'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products: ${response.statusCode}');
  }
}
