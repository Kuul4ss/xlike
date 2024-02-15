part of 'update_post_bloc.dart';

enum UpdatePostStatus {
  initial,
  loading,
  success,
  error,
}

class UpdatePostState {
  final UpdatePostStatus status;
  final Post? post;
  final Exception? error;

  UpdatePostState({
    this.status = UpdatePostStatus.initial,
    this.post,
    this.error,
  });

  UpdatePostState copyWith({
    UpdatePostStatus? status,
    Post? post,
    Exception? error,
  }) {
    return UpdatePostState(
      status: status ?? this.status,
      post: post ?? this.post,
      error: error ?? this.error,
    );
  }
}
