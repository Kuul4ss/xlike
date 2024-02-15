import 'dart:ffi';

class CreateCommentRequest{
  int postId;
  String content;

  CreateCommentRequest({
    required this.postId,
    required this.content
});

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'content': content,
    };
  }
}