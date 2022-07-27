import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:tugasakhir_app/model/user_model.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("id", user.id!);
    prefs.setString("name", user.name!);
    prefs.setString("email", user.email!);
    prefs.setInt("umur", user.umur!.toInt());
    prefs.setString("gender", user.gender!);
    prefs.setDouble("tinggi", user.tinggi!.toDouble());
    prefs.setDouble("berat", user.berat!.toDouble());
    prefs.setDouble("kaloriHarian", user.kaloriHarian!.toDouble());
    prefs.setString("token", user.token!);

    print("object prefere");
    print(user);

    return prefs.commit();
  }

  Future<UserModel> getUser(args) async {
  // void getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? id = prefs.getInt("id");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? token = prefs.getString("token");

    return UserModel(
        id: id,
        name: name,
        email: email,
        token: token,);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("umur");
    prefs.remove("gender");
    prefs.remove("tinggi");
    prefs.remove("berat");
    prefs.remove("kaloriHarian");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
