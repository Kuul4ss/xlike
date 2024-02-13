import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xlike/models/post.dart';
import 'package:xlike/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/posts/screens/add_post_screen.dart';
import 'package:xlike/posts/screens/post_detail_screen.dart';
import 'package:xlike/posts/widgets/account_icon.dart';
import 'package:xlike/posts/widgets/post_item.dart';

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
    loadUserData();
  }

  void _onLoginIconTap(BuildContext context) {
    // go to login page
  }

  void _onAddPost(BuildContext context) {
    AddPostScreen.navigateTo(context);
  }

  Future<void> _refreshPosts() async {
    final postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(GetAllPosts());
  }

  Future<Map<String, String>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the data from SharedPreferences
    String? id = prefs.getString('id');
    String? authToken = prefs.getString('authToken');

    return {
      'id': id ?? '',
      'authToken': authToken ?? '',
    };
  }

  void loadUserData() async {
    try {
      Map<String, String> userData = await getUserData();
      print("User id: ${userData['id']}");
      print("Auth Token: ${userData['authToken']}");
    } catch (e) {
      print("Failed to load user data: $e");
    }
  }


}

