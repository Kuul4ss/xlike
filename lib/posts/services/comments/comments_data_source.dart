
import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';

abstract class CommentsDataSource {
  Future<Comment> addComment(CreateCommentRequest request);
}
