import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/loading_pages/landing.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/sign_in_page.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/screens/main_screens/profile/extend_bantuan/bantuan.dart';
import 'package:tugasakhir_app/screens/main_screens/profile/extend_profile/edit_profile.dart';
import 'package:tugasakhir_app/screens/question/pre_question.dart';
import 'package:tugasakhir_app/screens/question/question1.dart';
import 'package:tugasakhir_app/screens/question/question2.dart';
import 'package:tugasakhir_app/screens/question/question3.dart';
import 'package:tugasakhir_app/screens/question/question4.dart';
import 'package:tugasakhir_app/screens/question/question5.dart';
import 'package:tugasakhir_app/screens/question/question6.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/pairing_device_screen.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/search_screen.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/tampildatamakanan.dart';
import 'package:tugasakhir_app/splash_screen.dart';

const String espUrl = 'ws://192.168.207.73:81';
void main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderFavoriteFood(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Share',
        ),
        debugShowCheckedModeBanner: false,

        initialRoute: '/splash_screen',

        routes: {
          // Entry App
          '/landing': (context) => const Landing(),

          // Splash Screen
          '/splash_screen': (context) => const SplashScreen(),


          // Routes register and login
          '/sign_in_page': (context) => const SignInPage(),

          // Routes Question
          '/prequestion': (context) => const PreQuestion(),
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
          '/bantuan': (context) => BantuanPage(),

          // Spoonycal
          '/pairing_device_screen': (context) => const PairingDeviceScreen(),
          '/search_screen': (context) => const SearchScreen(),
          '/tampil_data': (context) => const TampilDataMakanan(),
        },
      ),
    );
  }
}
