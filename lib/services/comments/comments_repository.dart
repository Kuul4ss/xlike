import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/services/comments/comments_data_source.dart';

class CommentsRepository {
  final CommentsDataSource commentsDataSource;

  CommentsRepository({required this.commentsDataSource});

  Future<Comment> addComment(CreateCommentRequest request) async {
    return commentsDataSource.addComment(request);
  }
}
