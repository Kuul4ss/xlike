import 'dart:ffi';

class CommentRequest{
  Int postId;
  String content;

  CommentRequest({
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