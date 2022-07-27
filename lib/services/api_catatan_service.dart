import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/model/makanan_model.dart';

class CatatanApiService {
  String finalToday = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String urlList = "https://spoonycal-ta.herokuapp.com/api/catatan";
  var data = [];
  List<Datum> results = [];

  Future<List<Datum>> getCatatanModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = await http.get(
        Uri.parse(urlList),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        results = (data as List).map((e) => Datum.fromJson(e)).toList();
        print(response.statusCode);
        print(results);
      } else {
        print(token);
        print(response.statusCode);
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }

  postCatatanModel({
    required String tanggal,
    required String waktu,
    required num kalori_masuk,
    required num target_kalori,
    required double sisa_kalori,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    try {
      var response = await http.post(Uri.parse(urlList),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$token',
          },
          body: jsonEncode({
            'tanggal': tanggal,
            'waktu': waktu,
            'kalori_masuk': kalori_masuk,
            'target_kalori': target_kalori,
            'sisa_kalori': sisa_kalori,
          }));
      print(kalori_masuk);
      print(target_kalori);
      print(sisa_kalori);
      print(response.statusCode);
      print(response.body);
      print(response.body);

      if (response.statusCode == 200) {
        print(token);
        print("Berhasil mengirim catatan!");
      } else {
        print(token);
        print(response.statusCode);
        print("Gagal mengirim catatan!");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
  }
}
