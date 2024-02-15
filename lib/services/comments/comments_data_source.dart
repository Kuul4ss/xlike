
import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';

abstract class CommentsDataSource {
  Future<Comment> createComment(CreateCommentRequest request);

  Future<void> deleteComment(int commentId);
}
