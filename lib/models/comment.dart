import 'user.dart';

class Comment {

  final int? id;
  final int? createdAt;
  final int? postId;
  final String? content;
  final User? author;

  const Comment({
    this.id,
    this.createdAt,
    this.postId,
    this.content,
    this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      createdAt: json["created_at"],
      postId: json["post_id"],
      content: json["content"],
      author: json["author"] == null ? null : User.fromJson(json["author"]),
    );
  }
}