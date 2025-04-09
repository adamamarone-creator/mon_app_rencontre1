import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
import 'edit_profile_page.dart';
import 'accueil_page.dart';  // Assurez-vous d'importer AccueilPage
import 'firebase_options.dart';  // Importer les options Firebase générées

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Assurez-vous que le fichier firebase_options.dart est bien généré
  );
  runApp(MonAppRencontre());
}
class MonAppRencontre extends StatelessWidget {
  const MonAppRencontre({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Rencontre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AccueilPage(),  // Page d'accueil
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/edit-profile': (context) => EditProfilePage(),  // Route vers le profil
      },
    );
  }
}
