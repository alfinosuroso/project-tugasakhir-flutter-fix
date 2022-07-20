import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/makanan_model.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';

class FetchDatumMakananList {
  var data = [];
  List<DatumMakananList> results = [];
  String urlList = "https://spoonycal-ta.herokuapp.com/api/makanan";

  Future<List<DatumMakananList>> getDatumMakananList({String? query}) async {
    try {
      var response = await http.get(
        Uri.parse(urlList),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $finalToken',
        },
      );

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('tesresp', response.statusCode);

      if (response.statusCode == 200) {
        data = json.decode(response.body)['data'];
        results = data.map((e) => DatumMakananList.fromJson(e)).toList();
        if (query != null) {
          print(response.statusCode);
          results = results
              .where((element) => element.makanan!
                  .toLowerCase()
                  .contains((query.toLowerCase())))
              .toList();
        }
      } else {
        print(finalToken);
        print(response.statusCode);
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}
