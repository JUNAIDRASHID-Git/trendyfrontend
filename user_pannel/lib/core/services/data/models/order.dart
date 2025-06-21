import 'package:trendychef/core/services/data/models/user_model.dart';

class OrderModel {
  final int id;
  final String userId;
  final UserModel user;
  final List<OrderItem> items;
  final double shippingCost;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.items,
    required this.shippingCost,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      user: UserModel.fromJson(json['user']), // FIXED HERE
      items:
          (json['items'] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList(),
      shippingCost: (json['shipping_cost'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json['status'],
      paymentMethod: json['payment_method'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'user': user.toJson(),
    'items': items.map((e) => e.toJson()).toList(),
    'shipping_cost': shippingCost,
    'total_amount': totalAmount,
    'status': status,
    'payment_method': paymentMethod,
    'created_at': createdAt.toIso8601String(),
  };
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productEName;
  final String productArName;
  final String productImage;
  final double productSalePrice;
  final double productRegularPrice;
  final double weight;
  final int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productEName,
    required this.productArName,
    required this.productImage,
    required this.productSalePrice,
    required this.productRegularPrice,
    required this.weight,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['ID'],
      orderId: json['OrderID'],
      productId: json['ProductID'],
      productEName: json['ProductEName'],
      productArName: json['ProductArName'],
      productImage: json['ProductImage'],
      productSalePrice: (json['ProductSalePrice']),
      productRegularPrice: (json['ProductRegularPrice']),
      weight: (json['Weight']),
      quantity: json['Quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': id,
    'OrderID': orderId,
    'ProductID': productId,
    'ProductEName': productEName,
    'ProductArName': productArName,
    'ProductImage': productImage,
    'ProductSalePrice': productSalePrice,
    'ProductRegularPrice': productRegularPrice,
    'Weight': weight,
    'Quantity': quantity,
  };
}
