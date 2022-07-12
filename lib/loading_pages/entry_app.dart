import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_in_page.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_up_page.dart';
import 'package:tugasakhir_app/main_screens/main_page.dart';

//Entry point of the app
class EntryApp extends StatefulWidget {
  const EntryApp({Key? key}) : super(key: key);

  @override
  State<EntryApp> createState() => _EntryAppState();
}

class _EntryAppState extends State<EntryApp> {
  bool isUserSignedIn = false;
  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  //check user login status
  Future<String> _checkLoginStatus() async {
    SharedPreferences localstorage = await SharedPreferences.getInstance();
    //Run the code after 200 milliseconds
    return Future.delayed(const Duration(milliseconds: 200), () {
      String userToken = localstorage.getString('token') ?? "";
      if (userToken.isNotEmpty) {
        if (mounted) {
          setState(() {
            isUserSignedIn = true;
          });
        }
      }
      return userToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        print(snapshot);
          if (snapshot.hasError) {
            return Center(
              child: Text('SOMETHING WENT WRONG, TAP TO RELOAD'),
            );
          } else if (snapshot.hasData) {
            return MainPage();
          } else {
            return SignUpPage();
          }
        } 
    );    
  }
}
