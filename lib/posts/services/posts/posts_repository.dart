import 'package:xlike/models/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    return postsDataSource.getAllPosts();
  }

  Future<List<Post>> getAllPostsOfUser(int userId) async {
    return postsDataSource.getAllPostsOfUser(userId);
  }


  Future<Post> getPostDetail(int id) async {
    return postsDataSource.getPostDetail(id);
  }

  Future<void> createPost(CreatePostRequest request) async {
    return postsDataSource.createPost(request);
  }
}
