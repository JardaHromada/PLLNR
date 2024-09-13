import 'package:firebase_auth/firebase_auth.dart'; //firebase import
import 'package:flutter/material.dart'; //flutter import
import 'package:plnn_test1/screens/home_screen.dart'; //screen import
import 'package:plnn_test1/screens/mytasks_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          // logged in
          if (snapshot.hasData){
            return MyTaskScreen(); //go into app
          }
          // not logged in
          else {
            return const HomeScreen(); //go to the opening(home) page(not great name but whatever)-> select log in or sign in
          }
        },
      ),
    );
  }
}