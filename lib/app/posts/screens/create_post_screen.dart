import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/login_screen.dart';
import 'package:xlike/app/posts/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:xlike/models/requests/create_post_request.dart';

class CreatePostScreen extends StatefulWidget {
  static const String routeName = '/addPost';

  static Future navigateTo(BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }

  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(VerifyToken());
  }

  File? _image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.status == AuthStatus.unauthenticated) {
        LoginScreen.navigateTo(context);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Créer un Post'),
        ),
        body: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state.status == CreatePostStatus.success) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
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
                      child: const Text('Ajouter une Image'),
                    ),
                    if (_image != null) ...[
                      Image.file(
                        _image!,
                        height: 200,
                      ),
                    ],
                    ElevatedButton(
                      onPressed: () => _submitPost(context),
                      child: const Text('Envoyer le post'),
                    ),
                  ],
                );
              case CreatePostStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      );
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

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
      final pickedFile = await picker.pickImage(source: source);
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
