import 'dart:io';

class CreatePostRequest {
  final String content;
  final File? base64Image;

  const CreatePostRequest({
    required this.content,
    this.base64Image,
  });
}