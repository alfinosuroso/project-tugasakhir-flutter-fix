import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Belum memiliki akun?",
          textAlign: TextAlign.center,
          style: Styles.bodyText6,
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/sign_up_page');
          },
          child: const Text(
            "Daftar disini",
            style: Styles.accountQuestionText2,
          ),
        )
      ],
    );
  }
}
