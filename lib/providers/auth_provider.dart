import 'package:flutter/material.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register(
      {required String name,
      required String email,
      required String password,
      required String gender,
      required double berat,
      required double tinggi,
      required double umur,
      required num kaloriHarian,
      }) async {
    try {
      UserModel user = await AuthService().register(
          name: name, email: email, password: password,
          gender: gender, berat: berat, tinggi: tinggi,
          umur: umur, kaloriHarian: kaloriHarian);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> myuser({required int id, String? token}) async {
    try {
      UserModel user =
          await AuthService().myuser(id: id, token: token);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editData(
      {required String token,
      required String name,
      required num berat,
      required num tinggi,
      required num umur,
      required num? kalori_harian,
      }) async {
    try {
      UserModel user = await AuthService().editData(
          token: token, name: name, berat: berat, tinggi: tinggi,
          umur: umur, kalori_harian: kalori_harian);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
}
