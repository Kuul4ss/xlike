import 'package:dio/dio.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/models/requests/update_post_request.dart';
import 'package:xlike/services/posts/posts_data_source.dart';

import '../client/dio_client.dart';

class PostsApiDataSource extends PostsDataSource {
  final DioClient dioClient;

  PostsApiDataSource({required this.dioClient});

  @override
  Future<List<Post>> getAllPosts(
      {RequestPaginationInfo? requestPaginationInfo}) async {
    try {
      Response response;
      if (requestPaginationInfo != null) {
        response = await dioClient.dio
            .get('/post', queryParameters: requestPaginationInfo.toJson());
      } else {
        response = await dioClient.dio.get('/post');
      }
      final jsonList = response.data['items'] as List;
      return jsonList.map((jsonElement) {
        return Post.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<Post>> getAllPostsOfUser(int userId,
      {RequestPaginationInfo? requestPaginationInfo}) async {
    try {
      Response response;
      if (requestPaginationInfo != null) {
        response = await dioClient.dio.get('/user/$userId/posts',
            queryParameters: requestPaginationInfo.toJson());
      } else {
        response = await dioClient.dio.get('/user/$userId/posts');
      }
      final jsonList = response.data['items'] as List;
      return jsonList.map((jsonElement) {
        return Post.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Post> getPostDetail(int id) async {
    try {
      final response = await dioClient.dio.get('/post/$id');
      final jsonElement = response.data;
      return Post.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> createPost(CreatePostRequest request) async {
    try {
      FormData formData = FormData.fromMap({
        'base_64_image': request.base64Image != null
            ? await MultipartFile.fromFile(request.base64Image!.path)
            : null,
        'content': request.content,
      });
      await dioClient.dio.post(
        '/post',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    try {
      await dioClient.dio.delete('/post/$postId');
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Post> updatePost(UpdatePostRequest request) async {
    try {
      FormData formData = FormData();
      if (request.content != null) {
        formData.fields.add(MapEntry(
          'content',
          request.content!,
        ));
      }
      if (request.base64Image != null) {
        formData.files.add(MapEntry<String, MultipartFile>(
          'base_64_image',
          await MultipartFile.fromFile(request.base64Image!.path),
        ));
      }
      final response = await dioClient.dio.patch(
        '/post/${request.postId}',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      final jsonElement = response.data;
      return Post.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }
}
