// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? message;
  final String? token;
  final int? branchId;
  final User? user;

  UserModel({
    this.message,
    this.token,
    this.branchId,
    this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        token: json["token"],
        branchId: json["branch_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "branch_id": branchId,
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? username;
  final String? balance;
  final String? currencyBalance;
  final String? image;
  final int? roleId;
  final String? countryCode;
  final int? order;
  final String? createDate;
  final String? updateDate;

  User({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.username,
    this.balance,
    this.currencyBalance,
    this.image,
    this.roleId,
    this.countryCode,
    this.order,
    this.createDate,
    this.updateDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        username: json["username"],
        balance: json["balance"],
        currencyBalance: json["currency_balance"],
        image: json["image"],
        roleId: json["role_id"],
        countryCode: json["country_code"],
        order: json["order"],
        createDate: json["create_date"],
        updateDate: json["update_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "username": username,
        "balance": balance,
        "currency_balance": currencyBalance,
        "image": image,
        "role_id": roleId,
        "country_code": countryCode,
        "order": order,
        "create_date": createDate,
        "update_date": updateDate,
      };
}
