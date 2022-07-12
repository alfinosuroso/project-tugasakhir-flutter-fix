import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  String _token = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    _token = (localStorage.getString('token') ?? "");
    if (_token == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, '/sign_in_page', ModalRoute.withName('/sign_in_page'));
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/main_page', ModalRoute.withName('/main_page'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}