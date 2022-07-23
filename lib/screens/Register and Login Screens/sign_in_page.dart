import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/dont_have_an_account.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/forget_password.dart';
import 'package:tugasakhir_app/screens/Register%20and%20Login%20Screens/sign_up_page.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool focusIcon = false;

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Styles.secondColor,
        content: Text(message.toString())));
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var responseLogin = await http.post(
          // Response /api/login
          Uri.parse("https://spoonycal-ta.herokuapp.com/api/login"),
          body: ({
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (responseLogin.statusCode == 200) {
        final dataLogin = jsonDecode(responseLogin.body);
        final SharedPreferences localStorage =
            await SharedPreferences.getInstance();
        localStorage.setString('name', dataLogin['data']['name']);
        localStorage.setString('email', dataLogin['data']['email']);
        localStorage.setString('token', dataLogin['access_token']);

        // Response /api/register
        //     String token = await Candidate().getToken();
        // final response = await http.get(url, headers: {
        //   'Content-Type': 'application/json',
        //   'Accept': 'application/json',
        //   'Authorization': 'Bearer $token',
        // });
        // print('Token : ${token}');
        // print(response);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[400],
            content: Text("Login Berhasil!")));

        // Navigator.popAndPushNamed(context, '/main_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Styles.buttonAuthBg,
            content: Text("Email atau Password Salah!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Styles.buttonAuthBg,
          content: Text("Email/Password Wajib diisi!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user;
    bool isLoading = false;

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
          email: emailController.text, password: passwordController.text)) {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => MainPage(
                      user: user!,
                    )));
        // Navigator.pushNamed(context, '/main_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.yellow,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

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
              onPressed: () {
                handleSignIn();
              },
              child: Text(
                "Login".toUpperCase(),
                style: Styles.buttonAuthText,
              ),
            ),
          ),
          const SizedBox(height: Styles.defaultPadding),
          ForgetPassword(),
          const Spacer(
            flex: 1,
          ),
          DontHaveAnAccount(),
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
