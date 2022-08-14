import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugasakhir_app/model/data_profile.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/already_have_an_account.dart';
import 'package:tugasakhir_app/styles.dart';

class QuestionFive extends StatefulWidget {
  const QuestionFive({Key? key}) : super(key: key);

  @override
  State<QuestionFive> createState() => _QuestionFiveState();
}

class _QuestionFiveState extends State<QuestionFive> {
  bool _notShowButtonRightArrow = true;

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
        title: const Image(
          image: AssetImage('assets/images/icon-question5.png'),
        ),
      ),
      // Badan Utama
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Teks 1 - Selamat Datang
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: const [
                  Text(
                    "Umur berapa Anda saat ini?",
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
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "",
                        contentPadding: EdgeInsets.all(10)),
                    onChanged: (value) {
                      setState(() {
                        if (DataProfile.controllerUmur.text != "") {
                          _notShowButtonRightArrow = false;
                        } else {
                          _notShowButtonRightArrow = true;
                        }
                      });
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                    ],
                    // inputFormatters: [
                    //   // FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                    //   FilteringTextInputFormatter.allow(
                    //       RegExp(r'^\d+\.?\d{0,2}')),
                    // ],
                    controller: DataProfile.controllerUmur,
                    style: Styles.inputFieldText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 120,
                  height: 65,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: const Text(
                    "Tahun",
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

            const SizedBox(
              height: 0,
            ),
            _notShowButtonRightArrow
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Image.asset('assets/images/rightArrowButton.png'),
                    iconSize: 42,
                    onPressed: () {
                      DataProfile().hitungUmur();
                      Navigator.pushNamed(context, '/question6');
                    },
                  ),

            const Spacer(
              flex: 1,
            ),

            // Teks 4 - Sudah memiliki akun?
            const Spacer(
              flex: 1,
            ),
            const AlreadyHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
