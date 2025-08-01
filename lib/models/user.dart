// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

class UserModel {
  final String? docId;
  final String? name;
  final String? phone;
  final String? address;
  final String? email;
  final int? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.phone,
    this.address,
    this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docID"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    email: json["email"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String userID) => {
    "docID": userID,
    "name": name,
    "phone": phone,
    "address": address,
    "email": email,
    "createdAt": createdAt,
  };
}
