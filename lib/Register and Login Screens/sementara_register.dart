import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugasakhir_app/Register and Login Screens/welcome_logout.dart';

class SementaraRegister extends StatefulWidget {
  const SementaraRegister({Key? key}) : super(key: key);

  @override
  State<SementaraRegister> createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<SementaraRegister> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* TITLE
            Text(
              'REGISTER WITH EMAIL/PASSWORD',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //* SIGN IN STATUS
            // CODE HERE: Change status based on current user
            const Text("You haven't signed in yet"),

            //* EMAIL TEXTFIELD
            Container(
              margin: const EdgeInsets.fromLTRB(30, 15, 30, 10),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: nameController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'name'),
              ),
            ),

            //* EMAIL TEXTFIELD
            Container(
              margin: const EdgeInsets.fromLTRB(30, 15, 30, 10),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: emailController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Email'),
              ),
            ),

            //* PASSWORD TEXTFIELD
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: passwordController,
                cursorColor: Colors.orange,
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Password'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //* SIGN UP BUTTON
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.orange.shade900)),
                      onPressed: () async {
                        register();
                      },
                      // CODE HERE: Change button text based on current user
                      child: const Text("Sign Up")),
                ),
                const SizedBox(
                  width: 15,
                ),

                //* SIGN IN BUTTON
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.orange.shade900)),
                      onPressed: () async {
                        login();
                      },
                      // CODE HERE: Change button text based on current user
                      child: const Text("Sign In")),
                ),
              ],
            ),

            //* RESET PASSWORD BUTTON
            TextButton(
                onPressed: () async {
                  // CODE HERE: Send reset code to the given email
                },
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.orange.shade900),
                ))
          ],
        ),
      ),
    );
  }

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.orange.shade900,
        content: Text(message.toString())));
  }

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://spoonycal-ta.herokuapp.com/api/login"),
          body: ({
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomeLogout()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email belum terdaftar!")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email/Password Wajib diisi!")));
    }
  }

  Future<void> register() async {
    if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://spoonycal-ta.herokuapp.com/api/register"),
          body: ({
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text
          }));
      if (response.statusCode == 200) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WelcomeLogout()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email sudah terdaftar!")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User/Email/Password Wajib diisi!")));
    }
  }
}
