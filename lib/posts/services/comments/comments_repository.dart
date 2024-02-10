import 'package:xlike/models/comment.dart';
import 'package:xlike/models/requests/add_comment_request.dart';
import 'package:xlike/posts/services/comments/comments_data_source.dart';

class CommentsRepository {
  final CommentsDataSource commentsDataSource;

  CommentsRepository({required this.commentsDataSource});

  Future<Comment> addComment(AddCommentRequest request) async {
    return commentsDataSource.addComment(request);
  }
}
