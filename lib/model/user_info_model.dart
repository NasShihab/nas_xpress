import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());

class Products {
  String? name;
  int? age;
  String? city;
  String? gender;
  int? phone;
  String? address1;
  String? role;

  Products({
    this.name,
    this.age,
    this.city,
    this.gender,
    this.phone,
    this.address1,
    this.role,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
