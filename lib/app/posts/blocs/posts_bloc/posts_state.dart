part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final Exception? error;

  PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.error,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    Exception? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
