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
        RepositoryProvider<PostsRepository>(
          create: (context) => PostsRepository(postsDataSource: PostsApiDataSource()),
        ),
        RepositoryProvider<CommentsRepository>(
          create: (context) => CommentsRepository(commentsDataSource: CommentsApiDataSource()),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(userDataSource: UserApiDataSource()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (context) => PostsBloc(postsRepository: context.read<PostsRepository>()),
          ),
          BlocProvider<PostDetailBloc>(
            create: (context) => PostDetailBloc(postsRepository: context.read<PostsRepository>()),
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
