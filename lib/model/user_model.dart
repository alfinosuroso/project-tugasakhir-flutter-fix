import 'dart:convert';

UserList userListFromJson(String str) => UserList.fromJson(json.decode(str));

String userListToJson(UserList data) => json.encode(data.toJson());

class UserList {
  UserList({
    this.data,
    this.accessToken,
    this.tokenType,
  });

  UserModel? data;
  String? accessToken;
  String? tokenType;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        data: UserModel.fromJson(json["data"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.umur,
    this.gender,
    this.tinggi,
    this.berat,
    this.kaloriHarian,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  String? name;
  String? email;
  num? umur;
  String? gender;
  num? tinggi;
  num? berat;
  num? kaloriHarian;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        email: json["email"],
        umur: json["umur"],
        gender: json["gender"],
        tinggi: json["tinggi"],
        berat: json["berat"],
        kaloriHarian: json["kalori_harian"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "umur": umur,
        "gender": gender,
        "tinggi": tinggi,
        "berat": berat,
        "kalori_harian": kaloriHarian,
        "updated_at": updatedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "id": id,
        "token": token,
      };
}
