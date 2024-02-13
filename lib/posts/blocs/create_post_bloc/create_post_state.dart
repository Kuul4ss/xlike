part of 'create_post_bloc.dart';

enum CreatePostStatus {
  initial,
  loading,
  success,
  error,
}

class CreatePostState {
  final CreatePostStatus status;
  final Exception? error;

  CreatePostState({
    this.status = CreatePostStatus.initial,
    this.error,
  });

  CreatePostState copyWith({
    CreatePostStatus? status,
    Exception? error,
  }) {
    return CreatePostState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
