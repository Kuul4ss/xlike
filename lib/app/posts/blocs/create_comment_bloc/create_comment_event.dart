part of 'create_comment_bloc.dart';

@immutable
abstract class CommentsEvent {}

class WritingComment extends CommentsEvent{}

class CreateComment extends CommentsEvent {
  final CreateCommentRequest request;

  CreateComment({required this.request});
}
