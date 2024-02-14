
import 'package:dio/dio.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/services/posts/posts_data_source.dart';

import '../client/dio_client.dart';

class PostsApiDataSource extends PostsDataSource {

  final DioClient dioClient;

  PostsApiDataSource({required this.dioClient});

  @override
  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo}) async {
    try {
      print('try getAllPosts request');
      Response response;
      if (requestPaginationInfo != null) {
        response = await dioClient.dio.get('/post', queryParameters: requestPaginationInfo.toJson());
      }
      else {
        response = await dioClient.dio.get('/post');
      }
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
  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo}) async {
    try {
      print('try getAllPostsOfUser request');
      Response response;
      if (requestPaginationInfo != null) {
        response = await dioClient.dio.get('/user/$userId/posts', queryParameters: requestPaginationInfo.toJson());
      }
      else {
        response = await dioClient.dio.get('/user/$userId/posts');
      }
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
      final response = await dioClient.dio.get('/post/$id');
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
      await dioClient.dio.post('/post', data: request.toJson());
    } catch (error) {
      print(error);
      rethrow;
    }
  }



}
