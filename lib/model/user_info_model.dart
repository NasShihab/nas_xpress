import 'dart:convert';

UserInfoModel productsFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String productsToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? name;
  String? age;
  String? city;
  String? gender;
  String? phone;
  String? address1;
  String? role;

  UserInfoModel({
    this.name,
    this.age,
    this.city,
    this.gender,
    this.phone,
    this.address1,
    this.role,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    name: json["name"],
    age: json["age"],
    city: json["city"],
    gender: json["gender"],
    phone: json["phone"],
    address1: json["address1"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "city": city,
    "gender": gender,
    "phone": phone,
    "address1": address1,
    "role": role,
  };
}
