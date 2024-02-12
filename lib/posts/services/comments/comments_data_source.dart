
import 'package:xlike/models/comment.dart';
import 'package:xlike/models/requests/add_comment_request.dart';

abstract class CommentsDataSource {
  Future<Comment> addComment(AddCommentRequest request);
}
