import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/login_screen.dart';
import 'package:xlike/app/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/app/posts/screens/add_post_screen.dart';
import 'package:xlike/app/posts/screens/post_detail_screen.dart';
import 'package:xlike/app/posts/widgets/account_icon.dart';
import 'package:xlike/app/posts/widgets/post_item.dart';
import 'package:xlike/models/domain/post.dart';

class PostsScreen extends StatefulWidget {
  static const String routeName = '/post';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(GetAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          AccountIcon(
            onTap: () => _onLoginIconTap(context),
          )
        ],
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          switch (state.status) {
            case PostsStatus.initial || PostsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case PostsStatus.error:
              return const Center(
                child: Text('Oups, une erreur est survenue.'),
              );
            case PostsStatus.success:
              final posts = state.posts;
              return RefreshIndicator(
                onRefresh: _refreshPosts,
                child: ListView.separated(
                  itemCount: posts.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostItem(
                      post: post,
                      onTap: () => _onPostTap(context, post),
                    );
                  },
                ),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.post_add),
        onPressed: () => _onAddPost(context),
      ),
    );
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  void _onLoginIconTap(BuildContext context) {
    LoginScreen.navigateTo(context);
  }

  void _onAddPost(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(VerifyToken());
    if (context.read<AuthBloc>().state.status == AuthStatus.authenticated) {
      AddPostScreen.navigateTo(context);
    } else {
      LoginScreen.navigateTo(context);
    }
  }

  Future<void> _refreshPosts() async {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(GetAllPosts());
  }
}
