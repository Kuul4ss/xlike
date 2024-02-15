import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/login_screen.dart';
import 'package:xlike/app/posts/blocs/create_comment_bloc/create_comment_bloc.dart';
import 'package:xlike/app/posts/blocs/delete_post_bloc/delete_post_bloc.dart';
import 'package:xlike/app/posts/blocs/posts_bloc/posts_bloc.dart';
import 'package:xlike/app/posts/screens/posts_screen.dart';
import 'package:xlike/models/domain/post.dart';
import 'package:xlike/app/posts/screens/user_posts_screen.dart';
import 'package:xlike/app/posts/widgets/comment_item.dart';
import 'package:xlike/app/posts/widgets/delete_icon.dart';
import 'package:xlike/app/posts/widgets/edit_icon.dart';
import 'package:xlike/app/posts/widgets/search_icon.dart';
import 'package:xlike/models/requests/create_comment_request.dart';

import '../blocs/post_detail_bloc/post_detail_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  static const String routeName = '/postDetail';

  static void navigateTo(BuildContext context, Post post) {
    Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final postDetailBloc = BlocProvider.of<PostDetailBloc>(context);
    postDetailBloc.add(GetPostDetail(id: widget.post.id!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeletePostBloc, DeletePostState>(
      listener: (context, state) {
        if (state.status == DeletePostStatus.success) {
          PostsScreen.navigateTo(context);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case DeletePostStatus.initial:
          case DeletePostStatus.success:
          case DeletePostStatus.error:
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Post detail'),
                    actions: [
                      if (state.status == AuthStatus.authenticated &&
                          state.user!.id == widget.post.author?.id) ...[
                        DeleteIcon(
                          onTap: () => _onDeleteIconTap(context),
                        ),
                        EditIcon(
                          onTap: () => _onEditIconTap(context),
                        ),
                      ],
                      SearchIcon(
                        onTap: () => _onSearchIconTap(context),
                      ),
                    ],
                  ),
                  body: BlocBuilder<PostDetailBloc, PostDetailState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case PostDetailStatus.initial || PostDetailStatus.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        case PostDetailStatus.error:
                          return const Center(
                            child: Text('Oups, une erreur est survenue.'),
                          );
                        case PostDetailStatus.success:
                          final post = state.post;
                          return Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            child: Icon(Icons.person,
                                                size: 20.0, color: Colors.white),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  post?.author?.name ?? "anonymous",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  DateFormat('yyyy-MM-dd – kk:mm')
                                                      .format(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                      post?.createdAt ?? 0)),
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (post?.image != null &&
                                          post?.image!.url != null) ...[
                                        const SizedBox(height: 10.0),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  _onImageTap(
                                                      context, post.image!.url!),
                                              child: Image.network(
                                                post!.image!.url!,
                                                height: 200,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 10.0),
                                      Text(post?.content.toString() ?? "nothing ?"),
                                      const SizedBox(height: 10.0),
                                      BlocConsumer<CreateCommentBloc,
                                          CreateCommentState>(
                                        listener: (context, state) {
                                          if (state.status ==
                                              CreateCommentStatus.success) {
                                            BlocProvider.of<PostDetailBloc>(context)
                                                .add(
                                              GetPostDetail(id: post!.id!),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          switch (state.status) {
                                            case CreateCommentStatus.initial:
                                            case CreateCommentStatus.success:
                                            case CreateCommentStatus.error:
                                              return Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons.comment,
                                                      size: 20.0,
                                                      color: Colors.grey),
                                                  const SizedBox(width: 5.0),
                                                  Text(post?.comments?.length
                                                      .toString() ??
                                                      "0"),
                                                ],
                                              );
                                            case CreateCommentStatus.writingComment:
                                              return Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 30,
                                                    child: Text(
                                                        'Contenue de votre Commentaire'),
                                                  ),
                                                  SizedBox(
                                                    height: 200,
                                                    child: SingleChildScrollView(
                                                      child: TextFormField(
                                                        controller: _textController,
                                                        keyboardType:
                                                        TextInputType.multiline,
                                                        maxLines: null,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () =>
                                                        _submitComment(context),
                                                    child:
                                                    Text('Envoyer le commentaire'),
                                                  ),
                                                ],
                                              );
                                            case CreateCommentStatus.addingComment:
                                              return const Center(
                                                child: CircularProgressIndicator(),
                                              );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: post?.comments?.length ?? 0,
                                  separatorBuilder: (context, _) =>
                                  const SizedBox(height: 5),
                                  itemBuilder: (context, index) {
                                    final comment = post?.comments?[index];
                                    return CommentItem(comment: comment!);
                                  },
                                ),
                              )
                            ],
                          );
                      }
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: const Icon(Icons.comment),
                    onPressed: () => _onAddComment(context),
                  ),
                );
              },
            );
          case DeletePostStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }
    );
  }

  void _onDeleteIconTap(BuildContext context) {
    BlocProvider.of<DeletePostBloc>(context).add(DeletePost(postId: widget.post.id!));
  }

  void _onEditIconTap(BuildContext context) {
    UserPostsScreen.navigateTo(context, widget.post.author!.id!);
  }

  void _onSearchIconTap(BuildContext context) {
    UserPostsScreen.navigateTo(context, widget.post.author!.id!);
  }

  void _onImageTap(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (_) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Image.network(
              url,
            ),
          ),
        ),
      ),
    );
  }

  void _onAddComment(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(VerifyToken());
    print('**** instant ***');
    if (context.read<AuthBloc>().state.status == AuthStatus.authenticated) {
      print('**** add event ***');
      BlocProvider.of<CreateCommentBloc>(context).add(WritingComment());
    } else if (context.read<AuthBloc>().state.status ==
        AuthStatus.unauthenticated) {
      LoginScreen.navigateTo(context);
    }
  }

  void _submitComment(BuildContext context) {
    BlocProvider.of<CreateCommentBloc>(context).add(
      CreateComment(
        request: CreateCommentRequest(
          postId: widget.post.id!,
          content: _textController.text,
        ),
      ),
    );
  }
}
