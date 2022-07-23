import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tugasakhir_app/loading_pages/landing.dart';
import 'package:tugasakhir_app/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/splash-image.png",
      duration: 1500,
      nextScreen: const Landing(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Styles.primaryColor,
    );
  }
}