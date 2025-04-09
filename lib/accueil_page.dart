import 'package:flutter/material.dart';
import 'login_page.dart';  // Import de la page de connexion
import 'signup_page.dart'; // Import de la page d'inscription
import 'edit_profile_page.dart'; // Import de la page de profil

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenue')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Bienvenue sur l\'app de rencontre !'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login'); // Naviguer vers la page de connexion
            },
            child: Text('Se connecter'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup'); // Naviguer vers la page d'inscription
            },
            child: Text('S\'inscrire'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile'); // Naviguer vers la page du profil
            },
            child: Text('Mon profil'),
          ),
        ],
      ),
    );
  }
}
