import 'package:flutter/material.dart';
import 'package:tugasakhir_app/Register and Login Screens/email_signin_page.dart';

class WelcomeLogout extends StatelessWidget {
  const WelcomeLogout({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Welcome"),
          TextButton(onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EmailSignInPage()));
          }, 
          child: Text("Logout"))
        ]),
    );
  }
}