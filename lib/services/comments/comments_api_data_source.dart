import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/services/client/dio_client.dart';
import 'package:xlike/services/comments/comments_data_source.dart';

class CommentsApiDataSource extends CommentsDataSource {
  final DioClient dioClient;

  CommentsApiDataSource({required this.dioClient});

  @override
  Future<Comment> createComment(CreateCommentRequest request) async {
    try {
      final response = await dioClient.dio.post(
        '/comment',
        data: request.toJson(),
      );
      final jsonElement = response.data;
      return Comment.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment(int commentId) async {
    try {
      await dioClient.dio.delete('/comment/$commentId');
    } catch (error) {
      rethrow;
    }
  }
}
