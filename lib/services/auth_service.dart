import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/util/shared_preference.dart';

class AuthService {
  String baseUrl = 'https://spoonycal-ta.herokuapp.com/api';

  Future<UserModel> register(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required double berat,
      required double tinggi,
      required double umur,
      required num kaloriHarian}) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'berat': berat,
      'tinggi': tinggi,
      'umur': umur,
      'kalori_harian': kaloriHarian,
    });

    print(jsonDecode(body));

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      var data = jsonDecode(response.body);
      print(data);
      UserModel user = UserModel.fromJson(data['data']);
      user.token = 'Bearer ' + data['access_token'];
      UserPreferences().saveUser(user);

      return user;
    } else {
      print("Gagal Register");
      throw Exception("Gagal Register");
    }
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    print(jsonDecode(body));

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // UserModel? user;
      print("Tes1");
      print(data['data']['token']);
      // print("Tes" + user!.umur.toString());
      UserModel user = UserModel.fromJson(data['data']);
      user.token = 'Bearer ' + data['access_token'];
      UserPreferences().saveUser(user);

      return user;
    } else {
      print("Gagal Login");
      throw Exception("Gagal Login");
    }
  }

  Future<UserModel> myuser({required int id, String? token}) async {
    var url = '$baseUrl/myuser/$id';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': '$token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['data']);
      user.token = 'Bearer ' + data['access_token'];
      UserPreferences().saveUser(user);

      return user;
    } else {
      print("Gagal Login");
      throw Exception("Gagal Login");
    }
  }
}
