// home_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/'); // Retour à AuthGate
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Bienvenue ${user?.email ?? "utilisateur"} !',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
