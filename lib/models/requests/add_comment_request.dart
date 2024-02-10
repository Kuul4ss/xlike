import 'dart:ffi';

class AddCommentRequest{
  Int postId;
  String content;

  AddCommentRequest({
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