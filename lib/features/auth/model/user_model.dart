class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String address;
  String profile;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.profile});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      profile: json["profile"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data["_id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["address"] = address;
    data["profile"] = profile;
    return data;
  }
}
