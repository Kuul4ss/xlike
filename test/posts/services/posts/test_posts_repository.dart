
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';

import 'test_posts_repository.mocks.dart';

@GenerateMocks([PostsDataSource])
void main() {
  group('PostsRepository', () {
    late MockPostsDataSource mockPostsDataSource;
    late PostsRepository postsRepository;
    setUp(() {
      mockPostsDataSource = MockPostsDataSource();
      postsRepository = PostsRepository(postsDataSource: mockPostsDataSource);
    });

    test('getAllPosts returns a list of posts', () async {
      // Mock
      when(mockPostsDataSource.getAllPosts(requestPaginationInfo: anyNamed('requestPaginationInfo')))
          .thenAnswer((_) async => [const Post(content: "test 1"), const Post(content: "test 2")]);

      // Call
      var result = await postsRepository.getAllPosts();

      // Test
      expect(result, isA<List<Post>>());
      expect(result.length, 2);

      // Verification
      verify(mockPostsDataSource.getAllPosts(requestPaginationInfo: anyNamed('requestPaginationInfo'))).called(1);
    });

    test('getPostDetail returns a post', () async {
      // Mock
      when(mockPostsDataSource.getPostDetail(0))
          .thenAnswer((_) async => const Post(id: 0, content: "test 1"));

      // Call
      var result = await postsRepository.getPostDetail(0);

      // Test
      expect(result, isA<Post>());
      expect(result.id, 0);

      // Verification
      verify(mockPostsDataSource.getPostDetail(0)).called(1);
    });

  });
}