import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlike/app/posts/screens/posts_screen.dart';

class AddPostScreen extends StatefulWidget {

  static const String routeName = '/addPost';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _textController = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un Post'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(labelText: 'Votre Post'),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Ajouter une Image'),
          ),
          if (_image != null) Image.file(_image!),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('Envoyer le post'),
            ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Affiche une feuille modale depuis le bas
    final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Caméra'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galerie'),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          );
        });

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  void _submitPost() {

    PostsScreen.navigateTo(context);
  }
}

