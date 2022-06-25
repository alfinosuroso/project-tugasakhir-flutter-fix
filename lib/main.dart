// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhir_app/pages/anon_signin_test.dart';
import 'package:tugasakhir_app/pages/email_signin_page.dart';
import 'package:tugasakhir_app/question1.dart';
import 'package:tugasakhir_app/wrapper.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // static const primaryColor = Color(0xFF45625D);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Warna Primary pada Question
        // primaryColor : primaryColor,

        // Font Default untuk Seluruh teks
        fontFamily: 'Share',

        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 96.0, fontFamily: 'Outfit', color: Colors.white),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // )
      ),

      // Membuat TextTheme
      debugShowCheckedModeBanner: false,
      home: EmailSignInPage(),
      // home: QuestionOne()
    );
  }
}
