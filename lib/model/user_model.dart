// To parse this JSON data, do
//
//     final UserToken = UserTokenFromJson(jsonString);

import 'dart:convert';

UserToken UserTokenFromJson(String str) => UserToken.fromJson(json.decode(str));

String UserTokenToJson(UserToken data) => json.encode(data.toJson());

class UserToken {
  UserToken({
    this.data,
    this.accessToken,
    this.tokenType,
  });

  UserModel? data;
  String? accessToken;
  String? tokenType;

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        data: UserModel.fromJson(json["data"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  String? name;
  String? email;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "token": token,
      };
}
