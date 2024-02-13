import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/domain/post.dart';
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
import 'package:xlike/authentication/services/user_data_source.dart';
import 'package:xlike/authentication/user_bloc/user_bloc.dart';
import 'authentication/authentication_bloc/authentication_bloc.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/screens/singup_screen.dart';
import 'authentication/services/api_data_source.dart';
import 'authentication/services/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: UserRepository(userDataSource: UserApiDataSource()));
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PostsRepository(
            postsDataSource: PostsApiDataSource(),
          ),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(userDataSource: UserApiDataSource()),
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
            create: (context) => UserPostsBloc(
              postsRepository: context.read<PostsRepository>(),
            ),
          ),
          BlocProvider<CommentsBloc>(
            create: (context) => CommentsBloc(commentsRepository: context.read<CommentsRepository>()),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(userRepository: context.read<UserRepository>()),
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) => _authenticationBloc,
          ),
        ],
        child: MaterialApp(
          routes: {
            '/addPost': (context) => const AddPostScreen(),
            '/signup': (context) => const SignupScreen(),
            '/login': (context) => const LoginScreen(),
            '/post': (context) => const PostsScreen(),
          },
          onGenerateRoute: (settings) {
            Widget content = const SizedBox();
            switch (settings.name) {
              case PostDetailScreen.routeName:
                final arguments = settings.arguments as Post?;
                if (arguments != null) {
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
          title: 'Votre App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.unauthenticated || state.status == AuthenticationStatus.uninitialized) {
                return const LoginScreen();
              } else if (state.status == AuthenticationStatus.authenticated) {
                return const PostsScreen();
              } else {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
