// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Choisissez votre rôle ',
                  style: GoogleFonts.robotoCondensed(
                    color: const Color.fromARGB(255, 13, 12, 12),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                // Images pour choisir le rôle
                Column(
                  children: [
                    // Premiere photo avec son texte
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'phoniatreSignupScreen');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 33, 194, 243), // Fond bleu
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 203, 166, 80), // Bordure marron
                            width: 3, // Épaisseur de la bordure
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 150, // Largeur fixe pour les images
                          height: 150, // Hauteur fixe pour les images
                          child: Column(
                            children: [
                              Image.asset(
                                'images/ho.jpg',
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Phoniatre',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(
                                      255, 7, 7, 7), // Texte blanc
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Deuxieme photo avec son texte
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'enfantSignupScreen');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          color:
                              Color.fromARGB(189, 172, 120, 111), // Fond rose
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 203, 166, 80), // Bordure marron
                            width: 3, // Épaisseur de la bordure
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: 150, // Largeur fixe pour les images
                          height: 150, // Hauteur fixe pour les images
                          child: Column(
                            children: [
                              Image.asset(
                                'images/hi.jpg',
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Enfant',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(
                                      255, 11, 11, 11), // Texte blanc
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                // Texte: Connexion
              ],
            ),
          ),
        ),
      ),
    );
  }
}
