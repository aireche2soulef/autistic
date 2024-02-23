// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JeuEnfant extends StatelessWidget {
  const JeuEnfant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Image.asset(
                          'images/hi.jpg', // Remplacez par le chemin de votre logo
                          width: 100, // Largeur du logo
                          height: 100, // Hauteur du logo
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "JEUX",
                            style: GoogleFonts.robotoCondensed(
                              color: const Color.fromARGB(255, 2, 2, 2),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pushNamed(context, 'HomeEnfant');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Test",
                          image: "images/testia.jpg",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "puzzle",
                          image: "images/d.jpg",
                          press: () {
                            Navigator.pushNamed(context, 'puzzEnfant');
                          },
                        ),
                        CategoryCard(
                          title: "Méditation",
                          image: "images/play.jpg",
                          press: () {
                            // Insérer ici l'action à effectuer lors de l'appui sur la méditation
                          },
                        ),
                        CategoryCard(
                          title: "Consultation",
                          image: "images/voire.jpg",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback press;

  const CategoryCard({
    required this.title,
    required this.image,
    required this.press,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(189, 172, 120, 111),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.cover, // Adapter l'image pour remplir le conteneur
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black, // Couleur du texte en noir
                  fontWeight: FontWeight.bold, // Texte en gras
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
