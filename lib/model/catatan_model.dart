import 'dart:convert';

CatatanModel catatanModelFromJson(String str) =>
    CatatanModel.fromJson(json.decode(str));

String catatanModelToJson(CatatanModel data) => json.encode(data.toJson());

class CatatanModel {
  CatatanModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Datum>? data;

  factory CatatanModel.fromJson(Map<String, dynamic> json) => CatatanModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.date,
    this.catatan,
  });

  DateTime? date;
  List<DatumCatatanModel>? catatan;

  Datum.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json["date"]);
    catatan = List<DatumCatatanModel>.from(
        json["catatan"].map((x) => DatumCatatanModel.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["date"] = date;
    data["catatan"] = List<dynamic>.from(catatan!.map((x) => x.toJson()));
    return data;
  }
}

class DatumCatatanModel {
  DatumCatatanModel({
    this.id,
    this.tanggal,
    this.waktu,
    this.kaloriMasuk,
    this.sisaKalori,
    this.targetKalori,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  DateTime? tanggal;
  String? waktu;
  num? kaloriMasuk;
  num? sisaKalori;
  num? targetKalori;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DatumCatatanModel.fromJson(Map<String, dynamic> json) =>
      DatumCatatanModel(
        id: json["id"],
        tanggal: DateTime.parse(json["tanggal"]),
        waktu: json["waktu"],
        kaloriMasuk: json["kalori_masuk"],
        sisaKalori: json["sisa_kalori"],
        targetKalori: json["target_kalori"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tanggal":
            "${tanggal?.year.toString().padLeft(4, '0')}-${tanggal?.month.toString().padLeft(2, '0')}-${tanggal?.day.toString().padLeft(2, '0')}",
        "waktu": waktu,
        "kalori_masuk": kaloriMasuk,
        "sisa_kalori": sisaKalori,
        "target_kalori": targetKalori,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
