import 'package:autism/enfant/welcomE.dart';
import 'package:autism/phoniatre/welcomP.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:autism/screens/login_screen.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Afficher un indicateur de chargement pendant que l'authentification est en cours.
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            User? user = snapshot.data;

            // Vérifier dans quelle collection se trouve l'utilisateur
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('phoniatres')
                  .doc(user!.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshotPhoniatre) {
                if (snapshotPhoniatre.connectionState == ConnectionState.done) {
                  if (snapshotPhoniatre.hasData &&
                      snapshotPhoniatre.data!.exists) {
                    // Rediriger vers l'interface Phoniatre si l'utilisateur est dans la collection "phoniatres"
                    return Homephoniatre();
                  }
                  // Si l'utilisateur n'est pas dans la collection "phoniatres", vérifier la collection "enfants"
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('enfants')
                        .doc(user.uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshotEnfant) {
                      if (snapshotEnfant.connectionState ==
                          ConnectionState.done) {
                        if (snapshotEnfant.hasData &&
                            snapshotEnfant.data!.exists) {
                          // Rediriger vers l'interface Enfant si l'utilisateur est dans la collection "enfants"
                          return HomeEnfant();
                        }
                      }
                      // Si aucun utilisateur n'est trouvé dans les collections, afficher un écran vide
                      return Container();
                    },
                  );
                }
                // Pendant la vérification, afficher un indicateur de chargement
                return Container();
              },
            );
          } else {
            // Si aucun utilisateur n'est connecté, afficher l'écran de connexion.
            return LoginScreen();
          }
        },
      ),
    );
  }
}
