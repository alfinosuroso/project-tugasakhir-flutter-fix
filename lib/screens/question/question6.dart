import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;

double? finalKaloriHarian;
int? tesStatus;

class QuestionSix extends StatefulWidget {
  const QuestionSix({Key? key}) : super(key: key);

  @override
  State<QuestionSix> createState() => _QuestionSixState();
}

class _QuestionSixState extends State<QuestionSix>
    with AfterLayoutMixin<QuestionSix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,

      // Appbar dengan arrow
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Styles.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      // Badan Utama
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 60, right: 60, bottom: 40),
        child: Column(
          children: [
            // Teks 1 - Selamat Datang
            const Spacer(
              flex: 1,
            ),
            const Text(
                "Kalori harian yang anda butuhkan adalah sebagai berikut",
                textAlign: TextAlign.center,
                style: Styles.headlineQuestion1),

            // Teks 2 - Pernyataan awal
            const Spacer(
              flex: 1,
            ),
            Container(
              alignment: Alignment.center,
              // width: 120,
              // height: 65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "$finalKaloriHarian".toString() + " kalori/hari",
                  style: Styles.inputFieldText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Teks 3 - Button Mengerti
            const Spacer(
              flex: 1,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff45625d)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                onPressed: () {
                  postKaloriHarian();
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Mengerti dan Lanjutkan!",
                    style: Styles.buttonMengertiText,
                    textAlign: TextAlign.center,
                  ),
                )),

            // Teks 4 - Sudah memiliki akun?
            const Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah memiliki akun?",
                  textAlign: TextAlign.center,
                  style: Styles.bodyText6,
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_in_page');
                  },
                  child: const Text(
                    "Masuk",
                    style: Styles.bodyText7,
                  ),
                ),
              ],
            ),
            Text("$tesStatus".toString())
          ],
        ),
      ),
    );
  }

  //** FUNGSI UNTUK MENGHITUNG KALORI HARIAN */
  @override
  void afterFirstLayout(BuildContext context) {
    tempKaloriHarian();
  }

  void tempKaloriHarian() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();

    final String? getGender = localStorage.getString("gender_user");
    final double? getBeratBadan = localStorage.getDouble("berat_badan");
    final double? getTinggiBadan = localStorage.getDouble("tinggi_badan");
    final double? getUmur = localStorage.getDouble("umur");

    if (getGender == 'Laki-Laki') {
      finalKaloriHarian = 66.5 +
          (13.8 * getBeratBadan!) +
          (5.0 * getTinggiBadan!) -
          (6.8 * getUmur!);
    } else if (getGender == 'Perempuan') {
      finalKaloriHarian = 655.1 +
          (9.6 * getBeratBadan!) +
          (1.9 * getTinggiBadan!) -
          (4.7 * getUmur!);
    }

    setState(() {
      finalKaloriHarian?.toStringAsFixed(2);
    });
  }

  Future<void> postKaloriHarian() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final String? getGender = localStorage.getString("gender_user");
    final double? getBeratBadan = localStorage.getDouble("berat_badan");
    final double? getTinggiBadan = localStorage.getDouble("tinggi_badan");
    final double? getUmur = localStorage.getDouble("umur");
    final String? getToken = localStorage.getString('token');

    if (getGender == 'Laki-Laki') {
      finalKaloriHarian = 66.5 +
          (13.8 * getBeratBadan!) +
          (5.0 * getTinggiBadan!) -
          (6.8 * getUmur!);
    } else if (getGender == 'Perempuan') {
      finalKaloriHarian = 655.1 +
          (9.6 * getBeratBadan!) +
          (1.9 * getTinggiBadan!) -
          (4.7 * getUmur!);
    }

    var responseProfil = await http.post(
        Uri.parse("https://spoonycal-ta.herokuapp.com/api/profile"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        },
        body: jsonEncode({
          'umur': getUmur,
          'gender': getGender,
          'tinggi': getTinggiBadan,
          'berat': getBeratBadan,
          'kalori_harian': finalKaloriHarian,
        }));

    print(responseProfil.statusCode);

    setState(() {
      tesStatus = responseProfil.statusCode;
    });
    if (responseProfil.statusCode == 201) {
      final dataProfile = jsonDecode(responseProfil.body);
      localStorage.setString('gender_user', dataProfile['data']['gender']);
      localStorage.setDouble('berat_badan', getBeratBadan!);
      localStorage.setDouble('tinggi_badan', getTinggiBadan!);
      localStorage.setDouble('umur', getUmur!);
      localStorage.setDouble(
          'kalori_harian', dataProfile['data']['kalori_harian']);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Styles.buttonAuthBg,
          content: Text("Berhasil menginputkan data!")));

      Navigator.popAndPushNamed(context, '/main_page');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Styles.buttonAuthBg,
          content: Text("Data ada yang belum benarrr!")));
    }
  }
}
