import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/posts/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:xlike/posts/screens/post_detail_screen.dart';
import 'package:xlike/posts/widgets/post_item.dart';

class UserPostsScreen extends StatefulWidget {
  static const String routeName = '/userPosts';

  static void navigateTo(BuildContext context, int userId) {
    Navigator.of(context).pushNamed(routeName, arguments: userId);
  }

  const UserPostsScreen({
    super.key,
    required this.userId,
  });

  final int userId;

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  void initState() {
    super.initState();
    final userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    userPostsBloc.add(GetAllPostsOfUser(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts d\'un utilisateur'),
      ),
      body: BlocBuilder<UserPostsBloc, UserPostsState>(
        builder: (context, state) {
          switch (state.status) {
            case UserPostsStatus.initial || UserPostsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case UserPostsStatus.error:
              return const Center(
                child: Text('Oups, une erreur est survenue.'),
              );
            case UserPostsStatus.success:
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
    );
  }

  void _onPostTap(BuildContext context, Post post) {
    PostDetailScreen.navigateTo(context, post);
  }

  Future<void> _refreshPosts() async {
    final userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    userPostsBloc.add(GetAllPostsOfUser(userId: widget.userId));
  }
}