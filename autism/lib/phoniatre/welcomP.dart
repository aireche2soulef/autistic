// ignore_for_file: prefer_const_constructors, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homephoniatre extends StatefulWidget {
  @override
  State<Homephoniatre> createState() => _Homephoniatre();
}

class _Homephoniatre extends State<Homephoniatre> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Bord Enseignant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la liste des élèves ou la page d'assignation d'activités
              },
              child: Text('Gérer les Élèves'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de suivi de progrès
              },
              child: Text('Suivi des Progrès'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page de retour d'informations
              },
              child: Text('Donner un Retour'),
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
