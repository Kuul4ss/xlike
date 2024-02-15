part of 'update_post_bloc.dart';

@immutable
abstract class UpdatePostEvent {}

class UpdatePost extends UpdatePostEvent {
  final UpdatePostRequest request;

  UpdatePost({required this.request});
}
