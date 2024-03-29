import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/models/requests/update_post_request.dart';
import 'package:xlike/services/posts/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo}) async {
    return postsDataSource.getAllPosts(requestPaginationInfo: requestPaginationInfo);
  }

  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo}) async {
    return postsDataSource.getAllPostsOfUser(userId);
  }

  Future<Post> getPostDetail(int id) async {
    return postsDataSource.getPostDetail(id);
  }

  Future<void> createPost(CreatePostRequest request) async {
    return postsDataSource.createPost(request);
  }

  Future<void> deletePost(int postId) async {
    return postsDataSource.deletePost(postId);
  }

  Future<Post> updatePost(UpdatePostRequest request) async {
    return postsDataSource.updatePost(request);
  }
}
