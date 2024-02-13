import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/domain/image.dart';
import 'package:xlike/models/domain/user.dart';

class Post {

  final int? id;
  final int? createdAt;
  final String? content;
  final Image? image;
  final User? author;
  final int? commentsCount;
  final List<Comment>? comments;

  const Post({
    this.id,
    this.createdAt,
    this.content,
    this.image,
    this.author,
    this.commentsCount,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      createdAt: json["created_at"],
      content: json["content"],
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      author: json["author"] == null ? null : User.fromJson(json["author"]),
      commentsCount: json["comments_count"],
      comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    );
  }
}
