part of 'comments_bloc.dart';

@immutable
abstract class CommentsEvent {}

class AddComment extends CommentsEvent {
  final CreateCommentRequest request;

  AddComment({required this.request});
}
