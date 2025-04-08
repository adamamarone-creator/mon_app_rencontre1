import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_service.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioController = TextEditingController();
  final ageController = TextEditingController();
  final locationController = TextEditingController();

  String selectedGender = 'Homme';
  String selectedReligion = 'Aucune';
  String selectedLookingFor = 'Amitié';
  List<String> selectedLanguages = [];
  List<String> selectedInterests = [];

  bool isProfilePublic = true;

  File? _profileImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        await saveUserProfile(
          uid: currentUser.uid,
          bio: bioController.text,
          gender: selectedGender,
          age: ageController.text,
          location: locationController.text,
          languages: selectedLanguages,
          religion: selectedReligion,
          lookingFor: selectedLookingFor,
          interests: selectedInterests,
          isPublic: isProfilePublic,
          photoUrl: null, // Pour l’instant, on ne gère pas le stockage Firebase
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil enregistré avec succès")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Créer / Éditer Profil"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                    : null,
                backgroundColor: Colors.pink,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: "Bio"),
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Âge"),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Localisation"),
            ),
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(labelText: "Sexe"),
              items: ['Homme', 'Femme', 'Autre']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
              onChanged: (val) => setState(() => selectedGender = val!),
            ),
            DropdownButtonFormField<String>(
              value: selectedReligion,
              decoration: InputDecoration(labelText: "Religion"),
              items: ['Aucune', 'Musulman(e)', 'Chrétien(ne)', 'Autre']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
              onChanged: (val) => setState(() => selectedReligion = val!),
            ),
            DropdownButtonFormField<String>(
              value: selectedLookingFor,
              decoration: InputDecoration(labelText: "Je cherche..."),
              items: ['Amitié', 'Relation sérieuse', 'Mariage']
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
              onChanged: (val) => setState(() => selectedLookingFor = val!),
            ),
            Wrap(
              spacing: 8.0,
              children: ['Français', 'Anglais', 'Arabe']
                  .map((lang) => FilterChip(
                        label: Text(lang),
                        selected: selectedLanguages.contains(lang),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedLanguages.add(lang);
                            } else {
                              selectedLanguages.remove(lang);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: ['Musique', 'Sport', 'Voyage', 'Lecture']
                  .map((interest) => FilterChip(
                        label: Text(interest),
                        selected: selectedInterests.contains(interest),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedInterests.add(interest);
                            } else {
                              selectedInterests.remove(interest);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            SwitchListTile(
              title: Text("Profil public"),
              value: isProfilePublic,
              onChanged: (val) => setState(() => isProfilePublic = val),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text("Enregistrer le profil", style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
