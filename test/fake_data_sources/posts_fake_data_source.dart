import 'dart:math';

import 'package:xlike/models/domain/image.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/models/requests/update_post_request.dart';
import 'package:xlike/services/posts/posts_data_source.dart';

class FakePostsDataSource extends PostsDataSource {
  List<Post> _posts = [];
  final Random _random = Random();

  @override
  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (requestPaginationInfo != null) {
      int startIndex = (requestPaginationInfo.page - 1) * requestPaginationInfo.perPage;
      int endIndex = min(startIndex + requestPaginationInfo.perPage, _posts.length);
      if (startIndex < _posts.length) {
        return _posts.sublist(startIndex, endIndex);
      }
    }
    return _posts;
  }

  @override
  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 1));
    List<Post> userPosts = _posts.where((post) => post.author?.id == userId).toList();
    if (requestPaginationInfo != null) {
      int startIndex = (requestPaginationInfo.page - 1) * requestPaginationInfo.perPage;
      int endIndex = min(startIndex + requestPaginationInfo.perPage, userPosts.length);
      if (startIndex < userPosts.length) {
        return userPosts.sublist(startIndex, endIndex);
      }
    }
    return userPosts;
  }

  @override
  Future<Post> getPostDetail(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _posts.firstWhere((post) => post.id == id, orElse: () => throw Exception("Post not found"));
  }

  @override
  Future<void> createPost(CreatePostRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    final newPost = Post(
      id: _random.nextInt(10000),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      content: request.content,
      image: Image(
        path: 'fake/path/to/image.jpg',
        name: 'image.jpg',
        type: 'image/jpeg',
        size: 12345,
        mime: 'image/jpeg',
        meta: null,
        url: 'https://fakeimageurl.com/image.jpg',
      ),
      author: User(
        id: _random.nextInt(100),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: 'Auteur Fictif',
        email: 'auteur@example.com',
      ),
      commentsCount: 0,
      comments: [],
    );
    _posts.add(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Post> updatePost(UpdatePostRequest request) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}
