import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/util/shared_preference.dart';

class AuthService {
  String baseUrl = 'https://spoonycal-ta.herokuapp.com/api';

  Future<UserModel> register(
      {required String name,
      required String email,
      required String password}) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
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
