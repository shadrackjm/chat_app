// ignore_for_file: prefer_const_constructors

import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/square_tile.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/my_textFields.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //  sign users in
  void signUpUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      showErrorMessage('password does not match');
    }

     // get auth service provider
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      authService.singUpWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showErrorMessage(e.toString());
    }
  }

//  create dialogs for email and password
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red[200],
            title: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // put a logo
                Icon(Icons.lock, size: 100),
                // here goes text -- hello again
                SizedBox(
                  height: 40,
                ),
                Text("Hello! create account",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 42,
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Fill form below",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                // username
                MyTextField(
                  controller: emailController,
                  textHint: 'Email',
                  ObsecureText: false,
                ),
                // password
                SizedBox(height: 20),

                MyTextField(
                  controller: passwordController,
                  textHint: 'Password',
                  ObsecureText: true,
                ),
                SizedBox(height: 20),

                MyTextField(
                  controller: confirmPasswordController,
                  textHint: 'Confirm Password',
                  ObsecureText: true,
                ),

                SizedBox(height: 15),
                // sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUpUser,
                ),
                SizedBox(height: 20),
                // not amember register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or Continue With"),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),
                    SizedBox(width: 20),
                    // google button
                    SquareTile(imagePath: 'lib/images/apple.png'),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "a member?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now!",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
