class AddPostRequest {
  final String content;
  final String? base64Image;

  const AddPostRequest({
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