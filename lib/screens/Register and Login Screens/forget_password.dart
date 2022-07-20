import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Lupa Password?",
          textAlign: TextAlign.center,
          style: Styles.bodyText6,
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            // Navigator.pushNamed(context, '/sign_up_page');
          },
          child: const Text(
            "Pulihkan Disini",
            style: Styles.accountQuestionText2,
          ),
        )
      ],
    );
  }
}
