import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'edit_profile_page.dart';
import 'accueil_page.dart'; // ancienne page d’accueil avec les boutons
import 'home_page.dart'; // page principale après profil complété

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> _getLandingPage() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return AccueilPage(); // pas connecté → accueil
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final data = doc.data();

    if (data == null || data['fullName'] == null || data['age'] == null) {
      return EditProfilePage(); // profil incomplet
    }

    return HomePage(); // profil complet → page principale
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getLandingPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Erreur de chargement.")),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
