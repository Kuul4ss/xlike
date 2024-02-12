import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/post.dart';
import 'package:xlike/posts/blocs/comments_bloc/comments_bloc.dart';
import 'package:xlike/posts/blocs/post_detail_bloc/post_detail_bloc.dart';
import 'package:xlike/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/posts/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:xlike/posts/screens/add_post_screen.dart';
import 'package:xlike/posts/screens/post_detail_screen.dart';
import 'package:xlike/posts/screens/posts_screen.dart';
import 'package:xlike/posts/screens/user_posts_screen.dart';
import 'package:xlike/posts/services/comments/comments_api_data_source.dart';
import 'package:xlike/posts/services/comments/comments_repository.dart';
import 'package:xlike/posts/services/posts/posts_api_data_source.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PostsRepository(
            postsDataSource: PostsApiDataSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => CommentsRepository(
            commentsDataSource: CommentsApiDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserPostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => PostDetailBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CommentsBloc(
              commentsRepository: context.read<CommentsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => const PostsScreen(),
            '/addPost': (context) => const AddPostScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();

            switch (settings.name) {
              case PostDetailScreen.routeName:
                final arguments = settings.arguments;
                if (arguments is Post) {
                  content = PostDetailScreen(post: arguments);
                }
                break;
              case UserPostsScreen.routeName:
                final arguments = settings.arguments;
                if (arguments is int) {
                  content = UserPostsScreen(userId: arguments);
                }
                break;
            }

            return MaterialPageRoute(builder: (context) => content);
          },
        ),
      ),
    );
  }
}
