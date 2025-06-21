import 'package:trendychef/core/services/data/models/product.dart';

class CategoryModel {
  int? iD;
  String? name;
  List<ProductModel>? products;

  CategoryModel({this.iD, this.name, this.products});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    if (json['Products'] != null) {
      products = <ProductModel>[];
      json['Products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
  }
}
