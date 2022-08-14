import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  int _id = 0;
  String _token = "";
  AuthProvider? authProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _handleMyUser();
    });
  }

  _handleMyUser() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    _id = (localStorage.getInt('id') ?? 0);
    _token = (localStorage.getString('token') ?? "");
    print(_token + 'EMAILLLLL' + _id.toString());
    if (_id != 0 || _token != "") {
      await authProvider?.myuser(id: _id, token: _token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage()),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, '/prequestion', ModalRoute.withName('/prequestion'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
