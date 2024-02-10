
import 'package:xlike/models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getAllPosts();

  Future<Post> getPostDetail(int id);
}
