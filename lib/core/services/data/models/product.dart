class ProductModel {
  final int id;
  final String name;
  final String description;
  final double salePrice;
  final double regularPrice;
  final double baseCost;
  final String image;
  final double weight;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.salePrice,
    required this.regularPrice,
    required this.baseCost,
    required this.image,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['ID'],
      name: json['Name'],
      description: json['Description'] ?? '',
      salePrice: (json['SalePrice'] as num).toDouble(),
      regularPrice: (json['RegularPrice'] as num).toDouble(),
      baseCost: (json['BaseCost'] as num).toDouble(),
      image: json['Image'],
      weight: (json['Weight'] as num).toDouble(),
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      deletedAt:
          json['DeletedAt'] != null
              ? DateTime.tryParse(json['DeletedAt'])
              : null,
    );
    
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': name,
      'Description': description,
      'SalePrice': salePrice,
      'RegularPrice': regularPrice,
      'BaseCost': baseCost,
      'Image': image,
      'Weight': weight,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
      'DeletedAt': deletedAt?.toIso8601String(),
    };
  }
}
