import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.appBarPrimaryColor,
      elevation: 0,
      automaticallyImplyLeading: true,  
    );
  }
}
