import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class PreQuestion extends StatelessWidget {
  
  const PreQuestion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,

      // Badan Utama
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width : double.infinity),

          const Spacer(
            flex: 1,
          ),

          // Widget 1 - Image Logo
          Image(image: AssetImage('assets/images/splash-image.png')),
          
          const Spacer(
            flex: 1,
          ),

          // Widget 2 - Belum Memiliki akun
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
                Navigator.pushNamed(context, '/question1');
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Saya belum memiliki akun",
                  style: Styles.buttonMengertiText,
                  textAlign: TextAlign.center,
                ),
              )),

              const SizedBox(height: 16.0),
              // Widget 3 - Sudah Memiliki akun
              ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff45625d)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Styles.buttonAuthBg),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ))),
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in_page');
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Saya sudah memiliki akun",
                  style: Styles.buttonMengertiText2,
                  textAlign: TextAlign.center,
                ),
              )),

          // Teks 4 - Sudah memiliki akun?
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}