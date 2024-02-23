// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnfantSignupScreen extends StatefulWidget {
  const EnfantSignupScreen({Key? key}) : super(key: key);

  @override
  State<EnfantSignupScreen> createState() => _EnfantSignupScreenState();
}

class _EnfantSignupScreenState extends State<EnfantSignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _prenomController = TextEditingController();
  final _numeroController = TextEditingController();

  Future<void> addPersonToDatabase() async {
    final _auth = FirebaseAuth.instance;

    try {
      if (_nameController.text.isEmpty ||
          _prenomController.text.isEmpty ||
          _numeroController.text.isEmpty ||
          _emailController.text.isEmpty) {
        print('Veuillez remplir tous les champs.');
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('enfants').doc(userId).set({
        'nom': _nameController.text.trim(),
        'prenom': _prenomController.text.trim(),
        'age': _numeroController.text.trim(),
        'email': _emailController.text.trim(),
      });

      print("Enfant ajouté à la base de données avec l'ID: $userId");

      // Vider les champs après l'inscription
      _nameController.clear();
      _prenomController.clear();
      _numeroController.clear();
      _emailController.clear();
      _passwordController.clear();
    } catch (e) {
      print("Erreur lors de l'ajout de l'enfant à la base de données: $e");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _prenomController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        child: Icon(Icons.home),
        backgroundColor: Color.fromARGB(189, 172, 120, 111),
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(189, 172, 120, 111),
                    border: Border.all(
                      color: Color.fromARGB(255, 203, 166, 80),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/cc.jpg',
                          height: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Inscrivez-vous',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 7, 7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 13),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromARGB(189, 172, 120, 111),
                            ),
                          ),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nom',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromARGB(189, 172, 120, 111),
                            ),
                          ),
                          child: TextField(
                            controller: _prenomController,
                            decoration: InputDecoration(
                              labelText: 'Prénom',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromARGB(189, 172, 120, 111),
                            ),
                          ),
                          child: TextField(
                            controller: _numeroController,
                            decoration: InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromARGB(189, 172, 120, 111),
                            ),
                          ),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        SizedBox(height: 13),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.fromARGB(189, 172, 120, 111),
                            ),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addPersonToDatabase,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(189, 172, 120, 111),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Color.fromARGB(255, 203, 166, 80),
                        width: 3,
                      ),
                    ),
                  ),
                  child: SizedBox(
                    width: 140,
                    height: 60,
                    child: Center(
                      child: Text(
                        'Enregistrer',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
