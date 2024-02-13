
import 'package:dio/dio.dart';
import 'package:xlike/models/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';

class PostsApiDataSource extends PostsDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
    ),
  );

  @override
  Future<List<Post>> getAllPosts() async {
    try {
      print('try getAllPosts request');
      final response = await dio.get('/post');
      print(response);
      final jsonList = response.data['items'] as List;
      return jsonList.map((jsonElement) {
        return Post.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  Future<List<Post>> getAllPostsOfUser(int userId) async {
    try {
      print('try getAllPostsOfUser request');
      final response = await dio.get('/user/$userId/posts');
      print(response);
      final jsonList = response.data['items'] as List;
      return jsonList.map((jsonElement) {
        return Post.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  Future<Post> getPostDetail(int id) async {
    try {
      print('try getPostDetail request');
      final response = await dio.get('/post/$id');
      final jsonElement = response.data;
      return Post.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  @override
  Future<void> createPost(CreatePostRequest request) async {
    try {
      print('try createPost request');
      await dio.post('/post', data: request.toJson());
    } catch (error) {
      print(error);
      rethrow;
    }
  }



}
