part of 'user_posts_bloc.dart';

@immutable
abstract class UserPostsEvent {}

class GetAllPostsOfUser extends UserPostsEvent {
  final int userId;

  GetAllPostsOfUser({required this.userId});
}
