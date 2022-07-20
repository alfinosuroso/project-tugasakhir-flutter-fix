import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProfile {
  // Inisialisasi
  static final TextEditingController controllerBeratBadan =
      TextEditingController();
  static final TextEditingController controllerTinggiBadan =
      TextEditingController();
  static final TextEditingController controllerUmur = TextEditingController();
  late String? controllerFemaleGender;
  late String? controllerMaleGender;
  late double? kaloriHarian;

  // Fungsi
  Future<void> genderLakiLaki() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('gender_user', 'Laki-Laki');
  }

  Future<void> genderPerempuan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('gender_user', 'Perempuan');    
  }

  Future<void> hitungBeratBadan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setDouble(
        'berat_badan', double.parse(controllerBeratBadan.text));
  }

  Future<void> hitungTinggiBadan() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setDouble(
        'tinggi_badan', double.parse(controllerTinggiBadan.text));
  }

  Future<void> hitungUmur() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setDouble(
        'umur', double.parse(controllerUmur.text));
  }
}
