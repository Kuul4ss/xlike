import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/services/comments/comments_data_source.dart';

class FakeCommentsDataSource extends CommentsDataSource {
  List<Comment> _comments = [];

  @override
  Future<Comment> addComment(CreateCommentRequest request) async {
    await Future.delayed(const Duration(seconds: 1));

    final newComment = Comment(
      id: _comments.length + 1,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      postId: request.postId,
      content: request.content,
      author: User(
        id: 1,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: 'Auteur Fictif',
        email: 'auteur@example.com',
      ),
    );

    _comments.add(newComment);

    return newComment;
  }
}
