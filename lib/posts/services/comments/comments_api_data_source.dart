
import 'package:dio/dio.dart';

import 'package:xlike/models/comment.dart';
import 'package:xlike/models/requests/add_comment_request.dart';
import 'package:xlike/posts/services/comments/comments_data_source.dart';

class CommentsApiDataSource extends CommentsDataSource {
  @override
  Future<Comment> addComment(AddCommentRequest request) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    try {
      print('try addComment request');
      final response = await dio.post('/comment');
      final jsonElement = response.data;
      return Comment.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      print('fucking error');
      rethrow;
    }
  }
}
