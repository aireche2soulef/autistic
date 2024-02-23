// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _ageController;
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  final Color shadowColor = Color.fromARGB(189, 172, 120, 111);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _ageController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _ageController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('enfants')
        .doc(user.uid)
        .get();

    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;
      setState(() {
        _nameController.text = data['nom'] ?? '';
        _surnameController.text = data['prenom'] ?? '';
        _ageController.text = data['age'] != null ? data['age'].toString() : '';
      });
    }
  }

  Future<void> updateUserProfile() async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('enfants')
        .doc(user.uid)
        .update({
      'nom': _nameController.text,
      'prenom': _surnameController.text,
      'age': int.tryParse(_ageController.text),
    });
    setState(() {
      // Mettre à jour les contrôleurs de texte avec les nouvelles valeurs
      _nameController.text = _nameController.text;
      _surnameController.text = _surnameController.text;
      _ageController.text = _ageController.text;
    });
  }

  Future<void> updatePassword() async {
    final user = FirebaseAuth.instance.currentUser!;
    if (_oldPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty) {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _oldPasswordController.text,
      );

      try {
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(_newPasswordController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mot de passe mis à jour avec succès')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la mise à jour du mot de passe'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editer Profil',
          style: GoogleFonts.robotoCondensed(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'HomeEnfant');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              backgroundColor: Color.fromARGB(189, 172, 120, 111),
              radius: 70,
              backgroundImage: AssetImage('images/hi.jpg'),
            ),
            const SizedBox(height: 20),
            itemProfile(
              'Nom',
              _nameController,
              Icons.person,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            itemProfile(
              'Prénom',
              _surnameController,
              Icons.person,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            itemProfile(
              'Age',
              _ageController,
              Icons.cake,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            itemProfile(
              'Mot de passe ',
              _oldPasswordController,
              Icons.lock,
              title2: 'Nouveau mot de passe',
              controller2: _newPasswordController,
              iconData2: Icons.lock_open,
              style: TextStyle(
                color: Color.fromARGB(255, 2, 2, 2),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget itemProfile(
    String title,
    TextEditingController controller,
    IconData iconData, {
    String? title2,
    TextEditingController? controller2,
    IconData? iconData2,
    TextStyle? style,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: shadowColor,
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: style,
        ),
        leading: Icon(iconData),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Color.fromARGB(189, 172, 120, 111),
                title: Text(
                  'Modifier $title',
                  style: style,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: title,
                      ),
                    ),
                    if (title2 != null &&
                        controller2 != null &&
                        iconData2 != null) ...[
                      SizedBox(height: 8),
                      TextField(
                        controller: controller2,
                        decoration: InputDecoration(
                          labelText: title2,
                        ),
                      ),
                    ],
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Annuler',
                      style: style,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      updateUserProfile();
                      updatePassword();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Sauvegarder',
                      style: style,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        subtitle: Text(
          controller.text,
        ),
      ),
    );
  }
}
