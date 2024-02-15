
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo});

  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo});

  Future<Post> getPostDetail(int id);

  Future<void> createPost(CreatePostRequest request);

  Future<void> deletePost(int postId);
}
