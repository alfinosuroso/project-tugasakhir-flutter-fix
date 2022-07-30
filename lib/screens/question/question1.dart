import 'package:flutter/material.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/already_have_an_account.dart';
import 'package:tugasakhir_app/styles.dart';

class QuestionOne extends StatefulWidget {
  const QuestionOne({Key? key}) : super(key: key);

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {
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
                        image: AssetImage('assets/images/icon-question1.png'),
                      ),
      ),
      // Badan Utama
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 60, right: 60, bottom: 40),
        child: Column(
          children: [
            // Teks 1 - Selamat Datang
            const Padding(
              padding: EdgeInsets.only(bottom: 80),
              child: Text("Selamat Datang",
                  textAlign: TextAlign.center, style: Styles.headlineQuestion1),
            ),

            // Teks 2 - Pernyataan awal
            const Spacer(
              flex: 1,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 140),
              child: Text(
                "Kami akan mengajukan beberapa pertanyaan untuk memberikan rekomendasi kalori harian Anda untuk mencapai target yang lebih fit",
                textAlign: TextAlign.center,
                style: Styles.bodyQuestion1,

                // TextStyle(
                //     fontSize: 16,
                //     fontFamily: "Poppins",
                //     color: Colors.white),
              ),
            ),

            // Teks 3 - Button Mengerti
            const Spacer(
              flex: 3,
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
                  Navigator.pushNamed(context, '/question2');
                },
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(43, 12, 43, 12),
                  child: Text(
                    "Mengerti",
                    style: Styles.buttonMengertiText,
                  ),
                )),

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
