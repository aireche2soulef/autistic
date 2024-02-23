// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:autism/auth.dart';
import 'package:autism/enfant/jeux/PuzzleGame.dart';
import 'package:autism/enfant/jeux/jeux.dart';
import 'package:autism/enfant/jeux/puzzle.dart';
import 'package:autism/enfant/jeux/puzzleSoeur.dart';
import 'package:autism/enfant/profilEnfant.dart';

import 'package:autism/enfant/welcomE.dart';
import 'package:autism/phoniatre/welcomP.dart';
import 'package:autism/screens/enfantlogin.dart';
import 'package:autism/screens/home_screen.dart';
import 'package:autism/screens/login_screen.dart';
import 'package:autism/screens/phoniatrelogin.dart';
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
        'homeScreen': (context) => HomeScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'phoniatreSignupScreen': (context) => const PhoniatreSignupScreen(),
        'enfantSignupScreen': (context) => const EnfantSignupScreen(),
        'HomeEnfant': (context) => HomeEnfant(),
        'Homephoniatre': (context) => Homephoniatre(),
        'user_profile': (context) => UserProfilePage(),
        'JeuEnfant': (context) => const JeuEnfant(),
        'puzzEnfant': (context) => puzzEnfant(),
        'PuzzleGame': (context) => PuzzleGame(),
        'PuzzleSOEUR': (context) => PuzzleSOEUR(),
      },
    );
  }
}
