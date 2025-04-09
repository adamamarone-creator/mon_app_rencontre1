import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  String _selectedGender = 'Homme';
  File? _imageFile;
  String? _imageUrl;

  final picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _db.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      _nameController.text = data['fullName'] ?? '';
      _bioController.text = data['bio'] ?? '';
      _selectedGender = data['gender'] ?? 'Homme';
      _imageUrl = data['profileImageUrl'];
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageAndSaveProfile() async {
    final uid = _auth.currentUser!.uid;

    // Upload image si une nouvelle a été sélectionnée
    if (_imageFile != null) {
      final ref = _storage.ref().child('profile_images/$uid.jpg');
      await ref.putFile(_imageFile!);
      _imageUrl = await ref.getDownloadURL();
    }

    // Sauvegarde Firestore
    await _db.collection('users').doc(uid).set({
      'fullName': _nameController.text,
      'bio': _bioController.text,
      'gender': _selectedGender,
      'profileImageUrl': _imageUrl,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profil enregistré avec succès !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier le profil')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : _imageUrl != null
                              ? NetworkImage(_imageUrl!) as ImageProvider
                              : AssetImage('assets/default_avatar.png'),
                      child: _imageFile == null && _imageUrl == null
                          ? Icon(Icons.add_a_photo, size: 30)
                          : null,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nom complet'),
                  ),
                  TextField(
                    controller: _bioController,
                    decoration: InputDecoration(labelText: 'Bio'),
                    maxLines: 3,
                  ),
                  DropdownButton<String>(
                    value: _selectedGender,
                    items: ['Homme', 'Femme'].map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedGender = val!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _uploadImageAndSaveProfile,
                    child: Text('Enregistrer le profil'),
                  ),
                ],
              ),
            ),
    );
  }
}
