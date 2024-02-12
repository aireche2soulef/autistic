// ignore_for_file: prefer_const_constructors

import "package:autism/screens/home_screen.dart";
import "package:autism/screens/login_screen.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
