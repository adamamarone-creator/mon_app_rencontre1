import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(String uid, Map<String, dynamic> userData) async {
    try {
      await usersCollection.doc(uid).set(userData);
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'utilisateur à Firestore : $e');
      rethrow;
    }
  }

  Future<void> uploadProfileImage(File imageFile) async {
    String uid = _auth.currentUser!.uid;
    final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

    // Upload
    await storageRef.putFile(imageFile);

    // Récupération de l'URL
    String downloadURL = await storageRef.getDownloadURL();

    // Sauvegarde dans Firestore
    await _db.collection('users').doc(uid).update({
      'profileImageUrl': downloadURL,
    });
  }
}

// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';

// class DatabaseService {
//   // ... garde ce qu’on avait avant

//   // Upload de l’image de profil et sauvegarde de son URL
//   Future<void> uploadProfileImage(File imageFile) async {
//     String uid = _auth.currentUser!.uid;
//     final storageRef = FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');

//     // Upload
//     await storageRef.putFile(imageFile);

//     // Récupération de l'URL
//     String downloadURL = await storageRef.getDownloadURL();

//     // Sauvegarde dans Firestore
//     await _db.collection('users').doc(uid).update({
//       'profileImageUrl': downloadURL,
//     });
//   }
// }

