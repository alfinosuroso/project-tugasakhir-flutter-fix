import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/model/makanan_model.dart';

class CatatanApiService {
  var data = [];
  List<Datum> results = [];
  String urlList = "https://spoonycal-ta.herokuapp.com/api/catatan";

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
}
