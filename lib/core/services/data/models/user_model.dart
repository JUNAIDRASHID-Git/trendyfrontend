class UserModel {
  String name;
  String email;
  String address;

  UserModel({required this.name, required this.email, required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
