part of 'user_posts_bloc.dart';

enum UserPostsStatus {
  initial,
  loading,
  success,
  error,
}

class UserPostsState {
  final UserPostsStatus status;
  final List<Post> posts;
  final Exception? error;

  UserPostsState({
    this.status = UserPostsStatus.initial,
    this.posts = const [],
    this.error,
  });

  UserPostsState copyWith({
    UserPostsStatus? status,
    List<Post>? posts,
    Exception? error,
  }) {
    return UserPostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
