// profile_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserProfile({
  required String uid,
  required String bio,
  required String gender,
  required String age,
  required String location,
  required List<String> languages,
  required String religion,
  required String lookingFor,
  required List<String> interests,
  required bool isPublic,
  required String? photoUrl,
}) async {
  await FirebaseFirestore.instance.collection('users').doc(uid).set({
    'bio': bio,
    'gender': gender,
    'age': age,
    'location': location,
    'languages': languages,
    'religion': religion,
    'lookingFor': lookingFor,
    'interests': interests,
    'isPublic': isPublic,
    'photoUrl': photoUrl,
    'createdAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}
