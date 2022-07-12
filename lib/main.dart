// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tugasakhir_app/pages/anon_signin_test.dart';
import 'package:tugasakhir_app/pages/email_signin_page.dart';
import 'package:tugasakhir_app/pages/sementara_register.dart';
import 'package:tugasakhir_app/pages_home/beranda.dart';
import 'package:tugasakhir_app/question1.dart';
import 'package:tugasakhir_app/question2.dart';
import 'package:tugasakhir_app/question3.dart';
import 'package:tugasakhir_app/question4.dart';
import 'package:tugasakhir_app/question5.dart';
import 'package:tugasakhir_app/question6.dart';
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
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Share',

        // textTheme: const TextTheme(
        //   headline1: TextStyle(fontSize: 96.0, fontFamily: 'Outfit', color: Colors.white),
        //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        // )
      ),

      debugShowCheckedModeBanner: false,
      // home: EmailSignInPage(),

      initialRoute: '/sign_up',

      getPages: [
        // Bagian Register, Login
         GetPage(
            name: '/sign_up',
            page: () => SementaraRegister(),
            transition: Transition.rightToLeftWithFade),

        GetPage(
            name: '/sign_in',
            page: () => EmailSignInPage(),
            transition: Transition.rightToLeftWithFade),

        // Bagian Question
        GetPage(name: '/question1', page: () => QuestionOne()),
        GetPage(
            name: '/question2',
            page: () => QuestionTwo(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/question3',
            page: () => QuestionThree(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/question4',
            page: () => QuestionFour(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/question5',
            page: () => QuestionFive(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/question6',
            page: () => QuestionSix(),
            transition: Transition.rightToLeftWithFade),

        // Bagian Beranda
        // GetPage(name: '/beranda', page: () => Beranda()),
      ],
    );
  }
}
