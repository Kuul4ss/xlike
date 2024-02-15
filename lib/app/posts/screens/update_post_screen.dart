import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xlike/app/posts/blocs/update_post_bloc/update_post_bloc.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/update_post_request.dart';

class UpdatePostScreen extends StatefulWidget {
  static const String routeName = '/editPost';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const UpdatePostScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  _UpdatePostScreenState createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final TextEditingController _textController = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    _textController.text = widget.post.content ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editer un Post'),
      ),
      body: BlocConsumer<UpdatePostBloc, UpdatePostState>(
        listener: (context, state) {
          if (state.status == UpdatePostStatus.success) {
            //PostDetailScreen.replaceTo(context, state.post!);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case UpdatePostStatus.success:
            case UpdatePostStatus.error:
            case UpdatePostStatus.initial:
              final post = widget.post;
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
                  if (post.image?.url != null && _image == null) ...[
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: GestureDetector(/*
                          onTap: () =>
                              _onImageTap(
                                  context, post.image!.url!),*/
                          child: Image.network(
                            post.image!.url!,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (_image != null) ...[
                    Image.file(
                      _image!,
                      height: 200,
                    ),
                  ],
                  ElevatedButton(
                    onPressed: () => _submitPost(context, post.id!),
                    child: const Text('Modifier le post'),
                  ),
                ],
              );
            case UpdatePostStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
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
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  void _submitPost(BuildContext context, int postId) {
    BlocProvider.of<UpdatePostBloc>(context).add(
      UpdatePost(
        request: UpdatePostRequest(
          postId: postId,
          content: _textController.text,
          base64Image: _image,
        ),
      ),
    );
  }
}
