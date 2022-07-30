import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Sudah memiliki akun?",
          textAlign: TextAlign.center,
          style: Styles.bodyText6,
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
            '/sign_in_page', (Route<dynamic> route) => false);
          },
          child: const Text(
            "Masuk",
            style: Styles.accountQuestionText2,
          ),
        )
      ],
    );
  }
}
