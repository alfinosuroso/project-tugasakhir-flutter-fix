import 'package:flutter/material.dart';
import 'package:tugasakhir_app/model/data_profile.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/already_have_an_account.dart';
import 'package:tugasakhir_app/styles.dart';

class QuestionTwo extends StatefulWidget {
  const QuestionTwo({Key? key}) : super(key: key);

  @override
  State<QuestionTwo> createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo> {
  bool _maleGender = false;
  bool _femaleGender = false;
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
                        image: AssetImage('assets/images/icon-question2.png'),
                      ),
      ),

      // Badan Utama
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Teks 1 - Jenis Kelamin
            const Text(
              "Apa Jenis Kelamin Anda?",
              textAlign: TextAlign.center,
              style: Styles.headlineQuestion1,
            ),

            // Teks 2.1 - Gambar Male
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _maleGender = !_maleGender;
                      _femaleGender = false;
                      if (_maleGender || _femaleGender) {
                        _notShowButtonRightArrow = false;
                      } else {
                        _notShowButtonRightArrow = true;
                      }
                    });
                  },
                  child: Image(
                    image: AssetImage('assets/images/maleButton.png'),
                    width: _maleGender ? 96 : 60,
                    height: _maleGender ? 96 : 60,
                  ),
                ),
                Text(
                  _maleGender ? 'Laki-Laki' : '',
                  style: Styles.bodyQuestion1,
                ),
              ],
            ),

            // Teks 2.2 - Gambar female
            const Spacer(
              flex: 1,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _femaleGender = !_femaleGender;
                      _maleGender = false;
                      if (_maleGender || _femaleGender) {
                        _notShowButtonRightArrow = false;
                      } else {
                        _notShowButtonRightArrow = true;
                      }
                    });
                  },
                  child: Image(
                    image: AssetImage('assets/images/femaleButton.png'),
                    width: _femaleGender ? 96 : 60,
                    height: _femaleGender ? 96 : 60,
                  ),
                ),
                Text(
                  _femaleGender ? 'Perempuan' : '',
                  style: Styles.bodyQuestion1,
                ),
              ],
            ),

            // Teks 3 - Button Right Arrow
            const Spacer(
              flex: 3,
            ),

            SizedBox(
              height: 20,
            ),
            _notShowButtonRightArrow
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Image.asset('assets/images/rightArrowButton.png'),
                    iconSize: 42,
                    onPressed: () {
                      if (_maleGender == true) {
                        DataProfile().genderLakiLaki();
                      } else if (_femaleGender == true) {
                        DataProfile().genderPerempuan();
                      }
                      Navigator.pushNamed(context, '/question3');
                    },
                  ),

            // Teks 4 - Sudah memiliki akun?
            const Spacer(
              flex: 1,
            ),
            AlreadyHaveAnAccount(),
          ],
        ),
      ),
    );
  }
}
