
import 'package:xlike/models/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<List<Post>> getAllPostsOfUser(int userId);

  Future<Post> getPostDetail(int id);

  Future<void> createPost(CreatePostRequest request);
}
