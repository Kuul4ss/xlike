import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/app/posts/blocs/create_comment_bloc/create_comment_bloc.dart';
import 'package:xlike/app/posts/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:xlike/app/posts/blocs/delete_post_bloc/delete_post_bloc.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/services/auth/auth_api_data_source.dart';
import 'package:xlike/services/auth/auth_repository.dart';
import 'package:xlike/services/client/dio_client.dart';
import 'package:xlike/services/comments/comments_api_data_source.dart';
import 'package:xlike/services/comments/comments_repository.dart';
import 'package:xlike/services/posts/posts_api_data_source.dart';
import 'package:xlike/services/posts/posts_repository.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/login_screen.dart';
import 'package:xlike/app/auth/screens/singup_screen.dart';
import 'package:xlike/app/posts/blocs/post_detail_bloc/post_detail_bloc.dart';
import 'package:xlike/app/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/app/posts/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:xlike/app/posts/screens/add_post_screen.dart';
import 'package:xlike/app/posts/screens/post_detail_screen.dart';
import 'package:xlike/app/posts/screens/posts_screen.dart';
import 'package:xlike/app/posts/screens/user_posts_screen.dart';

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
          create: (context) => AuthRepository(
            authDataSource: AuthApiDataSource(dioClient: DioClient()),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostsRepository(
            postsDataSource: PostsApiDataSource(dioClient: DioClient()),
          ),
        ),
        RepositoryProvider(
          create: (context) => CommentsRepository(
            commentsDataSource: CommentsApiDataSource(dioClient: DioClient()),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
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
            create: (context) => CreatePostBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DeletePostBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CreateCommentBloc(
              commentsRepository: context.read<CommentsRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => const PostsScreen(),
            '/addPost': (context) => const AddPostScreen(),
            '/signup': (context) => const SignupScreen(),
            '/login': (context) => const LoginScreen(),
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
