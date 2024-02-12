// ignore_for_file: prefer_const_constructors

import 'package:autism/auth.dart';
import 'package:autism/screens/home_screen.dart';
import 'package:autism/screens/login_screen.dart';
import 'package:autism/screens/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBMI8x9uIiSEvof3faBq-50WNwrKA_F6N0",
        appId: "1:822148204825:android:628078939b91098f0d9d88",
        messagingSenderId: "822148204825",
        projectId: "fir-13560"),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: Auth(),
      routes: {
        '/': (context) => const Auth(),
        'homeScreen': (context) => const HomeScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'loginScreen': (context) => const LoginScreen(),
      },
    );
  }
}
