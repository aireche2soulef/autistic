// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<int> order =
      List.generate(9, (index) => index); // Initial order of pieces
  int emptyIndex = 8; // Initial index of the empty cell
  bool gameWon = false;

  // Liste représentant l'ordre attendu des images
  List<int> expectedOrder = [0, 3, 6, 1, 4, 7, 2, 5, 8];

  @override
  void initState() {
    super.initState();
    _shuffleTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color.fromARGB(189, 172, 120, 111), // Couleur de l'AppBar
        title: Text(
          'Maman',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true, // Centrer le texte "Maman"
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'images/hi.jpg',
            width: 300,
            height: 300,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, 'puzzEnfant');
            },
          ),
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (!gameWon) _moveTile(index);
                  },
                  child: GridTile(
                    child: Image.asset(
                      'images/${order[index]}.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            if (gameWon)
              _buildDialog(), // Afficher la boîte de dialogue si le joueur a gagné
          ],
        ),
      ),
    );
  }

  Widget _buildDialog() {
    return Center(
      child: AlertDialog(
        title: Text(
          '🎉 Bravo! Vous avez gagné! 🎉',
          style: TextStyle(
            color: const Color.fromARGB(255, 33, 194, 243),
          ),
        ),
        backgroundColor: Color.fromARGB(189, 172, 120, 111),
        content: Container(
          width: double.minPositive,
          height: 200,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
                child: Image.asset(
                  'images/${expectedOrder[index]}.jpg',
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _replay(); // Réinitialiser le jeu
            },
            child: Text(
              'Rejouer',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(189, 172, 120, 111)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, 'puzzEnfant'); // Retour à la page précédente
            },
            child: Text(
              'Retour',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(189, 172, 120, 111)),
            ),
          ),
        ],
      ),
    );
  }

  void _replay() {
    setState(() {
      _shuffleTiles(); // Mélanger les tuiles pour recommencer le jeu
      gameWon = false; // Réinitialiser l'état du jeu
    });
  }

  void _moveTile(int tappedIndex) {
    setState(() {
      _swapTiles(tappedIndex);
      _checkWin();
    });
  }

  void _swapTiles(int tappedIndex) {
    // Swap the tapped tile with the empty cell
    int temp = order[tappedIndex];
    order[tappedIndex] = order[emptyIndex];
    order[emptyIndex] = temp;
    emptyIndex = tappedIndex;
  }

  void _checkWin() {
    // Vérifie si l'ordre actuel correspond à l'ordre attendu
    bool win = List.generate(9, (index) => order[index] == expectedOrder[index])
        .reduce((value, element) => value && element);

    if (win) {
      setState(() {
        gameWon = true;
      });
    }
  }

  void _shuffleTiles() {
    setState(() {
      order.shuffle();
      emptyIndex = order.indexOf(8);
      gameWon = false; // Réinitialiser l'état du jeu
    });
  }
}
