// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_in_page.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_up_page.dart';
import 'package:tugasakhir_app/loading_pages/landing.dart';
import 'package:tugasakhir_app/loading_pages/entry_app.dart';
// import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_in_page.dart';
import 'package:tugasakhir_app/main_screens/main_page.dart';
import 'package:tugasakhir_app/Register and Login Screens/email_signin_page.dart';
import 'package:tugasakhir_app/Register and Login Screens/sementara_register.dart';
import 'package:tugasakhir_app/main_screens/profile/extend_profile/edit_profile.dart';
import 'package:tugasakhir_app/question1.dart';
import 'package:tugasakhir_app/question2.dart';
import 'package:tugasakhir_app/question3.dart';
import 'package:tugasakhir_app/question4.dart';
import 'package:tugasakhir_app/question5.dart';
import 'package:tugasakhir_app/question6.dart';
import 'package:tugasakhir_app/splash_screen.dart';
import 'package:tugasakhir_app/wrapper.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Share',
      ),
      debugShowCheckedModeBanner: false,
      // home: EmailSignInPage(),

      initialRoute: '/sign_in_page',

      routes: {
        // Entry App
        '/landing': (context) => const Landing(),

        // Splash Screen
        '/splash_screen': (context) => const SplashScreen(),

        // Loading
        // '/default_loading': (context) => const Defa(),

        // Routes register and login
        '/sign_in_page': (context) => const SignInPage(),
        '/sign_up_page': (context) => const SignUpPage(),

        // Routes Question
        '/question1': (context) => const QuestionOne(),
        '/question2': (context) => const QuestionTwo(),
        '/question3': (context) => const QuestionThree(),
        '/question4': (context) => const QuestionFour(),
        '/question5': (context) => const QuestionFive(),
        '/question6': (context) => const QuestionSix(),

        // Routes Main Page
        '/main_page': (context) => const MainPage(),

        // Routes Extend Profile
        '/edit_profile': (context) => const EditProfile(),
      },
    );
  }
}
