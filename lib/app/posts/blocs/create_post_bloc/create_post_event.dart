part of 'create_post_bloc.dart';

@immutable
abstract class CreatePostEvent {}

class CreatePost extends CreatePostEvent {
  final CreatePostRequest request;

  CreatePost({required this.request});
}
