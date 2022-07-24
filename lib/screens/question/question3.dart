import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tugasakhir_app/model/data_profile.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:after_layout/after_layout.dart';

class QuestionThree extends StatefulWidget {
  const QuestionThree({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionThree> createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {
  bool _notShowButtonRightArrow = true;

  @override
  Widget build(BuildContext context) {
    ThemeData;
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
        title: const Image(
                        image: AssetImage('assets/images/icon-question3.png'),
                      ),
      ),
      // Badan Utama
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 60, right: 60, bottom: 40),
        child: Column(
          children: [
            // Teks 1 - Selamat Datang
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    "Berapakah berat badan Anda saat ini?",
                    textAlign: TextAlign.center,
                    style: Styles.headlineQuestion1,
                  ),
                  Text(
                    "Anda dapat mengubahnya nanti",
                    textAlign: TextAlign.center,
                    style: Styles.headlineQuestion2,
                  ),
                ],
              ),
            ),

            // Teks 2 - Textsize Berat Badan
            const Spacer(
              flex: 1,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 65,
                  color: Styles.secondColor,
                  margin: EdgeInsets.all(5),
                  child: TextField(
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "",
                        contentPadding: EdgeInsets.all(10)),
                    // inputFormatters: [
                    //   WhitelistingTextInputFormatter(
                    //       RegExp(r'^(\d+)?\.?\d{0,2}')),
                    // ],
                    onChanged: (value) {
                      setState(() {
                        if (DataProfile.controllerBeratBadan.text != "") {
                          _notShowButtonRightArrow = false;
                        } else {
                          _notShowButtonRightArrow = true;
                        }
                      });
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    controller: DataProfile.controllerBeratBadan,
                    style: Styles.inputFieldText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 65,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Text(
                    "Kg",
                    style: Styles.inputFieldText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            // Teks 3 - Button Right Arrow
            const Spacer(
              flex: 2,
            ),

            SizedBox(
              height: 0,
            ),
            _notShowButtonRightArrow
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Image.asset('assets/images/rightArrowButton.png'),
                    iconSize: 42,
                    onPressed: () {
                      DataProfile().hitungBeratBadan();
                      Navigator.pushNamed(context, '/question4');
                    },
                  ),

            const Spacer(
              flex: 1,
            ),

            // Teks 4 - Sudah memiliki akun?
            const Spacer(
              flex: 1,
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
                    Navigator.pushNamed(context, '/question4');
                  },
                  child: const Text(
                    "Masuk",
                    style: Styles.bodyText7,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}