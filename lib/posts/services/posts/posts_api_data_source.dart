
import 'package:dio/dio.dart';
import 'package:xlike/models/post.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';

class PostsApiDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    try {
      print('try getAllPosts request');
      final response = await dio.get('/post');
      final jsonList = response.data['items'] as List;
      return jsonList.map((jsonElement) {
        return Post.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      print('fucking error');
      rethrow;
    }
  }

  @override
  Future<Post> getPostDetail(int id) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
      ),
    );

    try {
      print('try getPostDetail request');
      final response = await dio.get('/post/$id');
      final jsonElement = response.data;
      return Post.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      print('fucking error');
      rethrow;
    }
  }
}
