// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bonjour ', // Correction ici : Utilisation de user.displayName
              style: TextStyle(fontSize: 22),
            ),
            Text(
              user.email!, // Correction ici : Utilisation de user.displayName
              style: TextStyle(fontSize: 22),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Color.fromARGB(189, 172, 120, 111),
              child: Text('Deconnexion'),
            ),
          ],
        ),
      ),
    );
  }
}
