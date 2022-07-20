import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/dont_have_an_account.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/forget_password.dart';
import 'package:tugasakhir_app/styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool focusIcon = false;

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Styles.secondColor,
        content: Text(message.toString())));
  }

  Future<void> register() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var responseRegister = await http.post(
          Uri.parse("https://spoonycal-ta.herokuapp.com/api/register"),
          body: ({
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (responseRegister.statusCode == 200) {
        final dataRegister = jsonDecode(responseRegister.body);
        final SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setInt('id', dataRegister['data']['id']);
        localStorage.setString('name', dataRegister['data']['name']);
        localStorage.setString('email', dataRegister['data']['email']);
        localStorage.setString('token', dataRegister['access_token']);


        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[400],
            content: Text("Pendaftaran Berhasil!")));

        Navigator.popAndPushNamed(context, '/question1');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Styles.buttonAuthBg,
            content: Text("Email sudah terdaftar!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Styles.buttonAuthBg,
          content: Text("Nama/Email/Password Wajib diisi!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 1,
          ),
          Image(
            image: AssetImage('assets/images/spoonycal mobile.png'),
            // width:
            // height:
          ),
          SizedBox(height: Styles.defaultPadding * 2),

          // Username
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                cursorColor: Styles.cursorColorGreen,
                style: Styles.inputFieldText2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Styles.textFormBg,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Styles.cursorColorGreen, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orangeAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  prefixIcon: Icon(
                    Icons.people_outline,
                    color: Colors.white,
                  ),
                  hintText: "Username",
                ),
              ),
            ),
          ),

          // Email
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: Styles.cursorColorGreen,
                style: Styles.inputFieldText2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Styles.textFormBg,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Styles.cursorColorGreen, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orangeAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  hintText: "Email",
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
                obscureText: true,
                cursorColor: Styles.cursorColorGreen,
                style: Styles.inputFieldText2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Styles.textFormBg,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Styles.cursorColorGreen, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.orangeAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.white,
                  ),
                  hintText: "Password",
                ),
              ),
            ),
          ),
          const SizedBox(height: Styles.defaultPadding),
          SizedBox(
            // tag: "login_btn",
            width: MediaQuery.of(context).size.width * 0.78,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Styles.buttonAuthBg,
                minimumSize: const Size.fromHeight(50),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () async {
                register();
              },
              child: Text(
                "Daftar".toUpperCase(),
                style: Styles.buttonAuthText,
              ),
            ),
          ),
          const SizedBox(height: Styles.defaultPadding),
          const ForgetPassword(),
          const Spacer(
            flex: 1,
          ),
          const DontHaveAnAccount(),
          const SizedBox(height: Styles.defaultPadding),

          //   AlreadyHaveAnAccountCheck(
          //     press: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return SignUpScreen();
          //           },
          //         ),
          //       );
          //     },
          //   ),
        ],
      ),
    );
  }
}
