
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/models/requests/create_post_request.dart';
import 'package:xlike/models/requests/request_pagination_info.dart';
import 'package:xlike/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/posts/screens/posts_screen.dart';
import 'package:xlike/posts/services/posts/posts_api_data_source.dart';
import 'package:xlike/posts/services/posts/posts_data_source.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';

class ErrorDataSource extends PostsDataSource {
  @override
  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
  }

  @override
  Future<void> createPost(CreatePostRequest request) async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
  }

  @override
  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
  }

  @override
  Future<Post> getPostDetail(int id) async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception();
  }
}

class EmptyDataSource extends PostsDataSource {
  @override
  Future<void> createPost(CreatePostRequest request) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getAllPostsOfUser(int userId, {RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }

  @override
  Future<Post> getPostDetail(int id) {
    // TODO: implement getPostDetail
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getAllPosts({RequestPaginationInfo? requestPaginationInfo}) async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }
}

Widget _setUpPostsScreen(PostsDataSource postsDataSource) {
  return RepositoryProvider(
    create: (context) => PostsRepository(
      postsDataSource: postsDataSource,
    ),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsBloc(
            postsRepository: context.read<PostsRepository>(),
          ),
        ),
      ],
      child: const MaterialApp(
        home: PostsScreen(),
      ),
    ),
  );
}

void main() {
  group('$PostsScreen', () {
    testWidgets('$PostsScreen should display the right title', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostsScreen(PostsApiDataSource()));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Posts'), findsOneWidget);
    });

    testWidgets('$PostsScreen should display an error if an error occurred', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostsScreen(ErrorDataSource()));
      await tester.pump(const Duration(seconds: 2));
      expect(find.text('Oups, une erreur est survenue.'), findsOneWidget);
    });

    testWidgets('$PostsScreen should display a loading indicator', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostsScreen(
        PostsApiDataSource(),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('$PostsScreen should display a loader when Loading', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpPostsScreen(PostsApiDataSource()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}