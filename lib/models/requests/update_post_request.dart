import 'dart:io';

class UpdatePostRequest {
  final int postId;
  final String? content;
  final File? base64Image;

  const UpdatePostRequest({
    required this.postId,
    this.content,
    this.base64Image,
  });
}