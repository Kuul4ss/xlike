import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/login_screen.dart';
import 'package:xlike/app/posts/blocs/create_comment_bloc/create_comment_bloc.dart';
import 'package:xlike/app/posts/screens/posts_screen.dart';
import 'package:xlike/models/requests/create_comment_request.dart';

class CreateCommentScreen extends StatefulWidget {
  static const String routeName = '/createComment';

  static void navigateTo(BuildContext context, int postId) {
    Navigator.of(context).pushNamed(routeName, arguments: postId);
  }

  const CreateCommentScreen({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(VerifyToken());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          LoginScreen.navigateTo(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Créer le commentaire'),
          ),
          body: BlocConsumer<CreateCommentBloc, CreateCommentState>(
            listener: (context, state) {
              if (state.status == CreateCommentStatus.success) {
                PostsScreen.navigateTo(context);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case CreateCommentStatus.success:
                case CreateCommentStatus.error:
                case CreateCommentStatus.initial:
                  return Column(
                    children: [
                      const SizedBox(
                        height: 30,
                        child: Text('Contenue de votre commentaire'),
                      ),
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: _textController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _submitComment(context),
                        child: const Text('Envoyer le commentaire'),
                      ),
                    ],
                  );
                case CreateCommentStatus.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        );
      },
    );
  }

  void _submitComment(BuildContext context) {
    BlocProvider.of<CreateCommentBloc>(context).add(
      CreateComment(
        request: CreateCommentRequest(
          postId: widget.postId,
          content: _textController.text,
        ),
      ),
    );
  }
}
