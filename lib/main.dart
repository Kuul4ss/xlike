import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/post.dart';
import 'package:xlike/posts/comments_bloc/comments_bloc.dart';
import 'package:xlike/posts/post_detail_bloc/post_detail_bloc.dart';

import 'package:xlike/posts/posts_bloc/posts_bloc.dart';
import 'package:xlike/posts/screens/post_detail_screen.dart';
import 'package:xlike/posts/screens/posts_screen.dart';
import 'package:xlike/posts/services/comments/comments_api_data_source.dart';
import 'package:xlike/posts/services/comments/comments_repository.dart';
import 'package:xlike/posts/services/posts/posts_api_data_source.dart';
import 'package:xlike/posts/services/posts/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/authentication/screens/singup_screen.dart';
import 'package:xlike/authentication/services/user_data_source.dart';
import 'package:xlike/authentication/user_bloc/user_bloc.dart';
import 'authentication/authentication_bloc/authentication_bloc.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/services/api_data_source.dart';
import 'authentication/services/user_repository.dart';

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
            create: (context) => PostDetailBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CommentsBloc(
              commentsRepository: context.read<CommentsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => const PostsScreen(),
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
            }

            return MaterialPageRoute(builder: (context) => content);
          },
          title: 'Votre App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                print("connecté");
                return LoginScreen();
              } else if (state.status == AuthenticationStatus.unauthenticated) {
                print("non connecté");
                return const LoginScreen();
              } else {
                print(state.status);
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
