// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeEnfant extends StatefulWidget {
  const HomeEnfant({Key? key}) : super(key: key);

  @override
  _HomeEnfantState createState() => _HomeEnfantState();
}

class _HomeEnfantState extends State<HomeEnfant> {
  bool _isSignedOut = false;

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
                          'images/hi.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "ACCUEIL",
                            style: GoogleFonts.robotoCondensed(
                              color: const Color.fromARGB(255, 2, 2, 2),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(1000, 70, 0, 0),
                            color: Color.fromARGB(189, 172, 120, 111),
                            items: [
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () async {
                                    print("Profil tapped");
                                    await Navigator.pushNamed(
                                        context, 'user_profile');
                                    if (_isSignedOut) {
                                      setState(() {
                                        _isSignedOut = false;
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 10),
                                      Text('Profil'),
                                    ],
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    setState(() {
                                      _isSignedOut = true;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.exit_to_app),
                                      SizedBox(width: 10),
                                      Text('Déconnexion'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        icon: Icon(Icons.menu, color: Colors.black),
                      ),
                    ],
                  ),
                  SearchBar(),
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
                          title: "Jeux",
                          image: "images/jeux.jpg",
                          press: () {
                            Navigator.pushNamed(context, 'JeuEnfant');
                          },
                        ),
                        CategoryCard(
                          title: "Méditation",
                          image: "images/play.jpg",
                          press: () {},
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

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // Placeholder pour la barre de recherche
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
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
