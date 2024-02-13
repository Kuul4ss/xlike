class CreatePostRequest {
  final String content;
  final String? base64Image;

  const CreatePostRequest({
    required this.content,
    this.base64Image,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'base_64_image': base64Image,
    };
  }
}