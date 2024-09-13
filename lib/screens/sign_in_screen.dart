import 'package:firebase_auth/firebase_auth.dart'; //firabase import
import 'package:flutter/material.dart'; //import flutter
import 'package:plnn_test1/screens/my_textfield.dart'; //textfield, button import
import 'package:plnn_test1/screens/my_button.dart';
import 'package:plnn_test1/screens/auth_page.dart'; //authpage import

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});

  final emailController = TextEditingController(); //text editing
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // sign in method
  void signUserUp(BuildContext context) async {  //signUserUp 
    try {
     if (passwordController.text == confirmpasswordController.text) { //check if password is correct
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
     }
    
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthPage()), 
      );
     } catch (e) {
      // handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: const BoxDecoration(color: Color(0xFF0E181E)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Vytvořit účet',
                      style: TextStyle(
                        color: Color(0xFFE0F0FF),
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF0E181E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    MyTextField(controller: emailController, hintText: "Email", obscureText: false),
                    const SizedBox(height: 24),
                    MyTextField(controller: passwordController, hintText: "Heslo", obscureText: true),
                    const SizedBox(height: 24),
                    MyTextField(controller: confirmpasswordController, hintText: "Potvrdit heslo", obscureText: true),
                    const SizedBox(height: 24),
                    MyButton(
                      text: "Registrovat se",
                      onTap: () => signUserUp(context)
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}