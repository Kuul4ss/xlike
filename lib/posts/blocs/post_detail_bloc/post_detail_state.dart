part of 'post_detail_bloc.dart';

enum PostDetailStatus {
  initial,
  loading,
  success,
  error,
}

class PostDetailState {
  final PostDetailStatus status;
  final Post? post;
  final Exception? error;

  PostDetailState({
    this.status = PostDetailStatus.initial,
    this.post,
    this.error,
  });

  PostDetailState copyWith({
    PostDetailStatus? status,
    Post? post,
    Exception? error,
  }) {
    return PostDetailState(
      status: status ?? this.status,
      post: post ?? this.post,
      error: error ?? this.error,
    );
  }
}
