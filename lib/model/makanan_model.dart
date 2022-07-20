// To parse this JSON data, do
//
//     final makananList = makananListFromJson(jsonString);

import 'dart:convert';

MakananList makananListFromJson(String str) =>
    MakananList.fromJson(json.decode(str));

String makananListToJson(MakananList data) => json.encode(data.toJson());

class MakananList {
  MakananList({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<DatumMakananList>? data;

  factory MakananList.fromJson(Map<String, dynamic> json) => MakananList(
        success: json["success"],
        message: json["message"],
        data: List<DatumMakananList>.from(
            json["data"].map((x) => DatumMakananList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DatumMakananList {
  DatumMakananList({
    this.id,
    this.makanan,
    this.kaloriPerGram,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? makanan;
  int? kaloriPerGram;
  DateTime? createdAt;
  DateTime? updatedAt;

  DatumMakananList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    makanan = json["makanan"];
    kaloriPerGram = json["kalori_per_gram"];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["makanan"] = makanan;
    data["kalori_per_gram"] = kaloriPerGram;
    data["created_at"] = createdAt?.toIso8601String();
    data["updated_at"] = updatedAt?.toIso8601String();
    return data;
  }
}
