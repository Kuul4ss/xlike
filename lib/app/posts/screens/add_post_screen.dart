import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlike/app/posts/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:xlike/app/posts/screens/posts_screen.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/utils/image_helper.dart';

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
        title: const Text('Créer un Post'),
      ),
      body: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
        if (state.status == CreatePostStatus.success) {
          PostsScreen.navigateTo(context);
        }
      }, builder: (context, state) {
        switch (state.status) {
          case CreatePostStatus.success:
          case CreatePostStatus.error:
          case CreatePostStatus.initial:
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                  child: Text('Contenue de votre Post'),
                ),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Ajouter une Image'),
                ),
                if (_image != null) ...[
                  Image.file(
                    _image!,
                    height: 200,
                  ),
                ],
                ElevatedButton(
                  onPressed: () => _submitPost(context),
                  child: Text('Envoyer le post'),
                ),
              ],
            );
          case CreatePostStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
        } /*

          return Column(
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
                onPressed: () => _submitPost(context),
                child: Text('Envoyer le post'),
              ),
            ],
          );*/
      }),
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
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camera'),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galerie'),
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

  void _submitPost(BuildContext context) {
    BlocProvider.of<CreatePostBloc>(context).add(
      CreatePost(
        request: CreatePostRequest(
          content: _textController.text,
          base64Image: _image,
        ),
      ),
    );
  }
}
