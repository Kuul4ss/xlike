import 'package:xlike/models/post.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';

class PostsRepository {
  final PostsDataSource postsDataSource;

  PostsRepository({required this.postsDataSource});

  Future<List<Post>> getAllPosts() async {
    return postsDataSource.getAllPosts();
  }

  Future<Post> getPostDetail(int id) async {
    return postsDataSource.getPostDetail(id);
  }
}
