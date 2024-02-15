part of 'create_comment_bloc.dart';

enum CreateCommentStatus {
  initial,
  writingComment,
  addingComment,
  success,
  error,
}

class CreateCommentState {
  final CreateCommentStatus status;
  final Exception? error;

  CreateCommentState({
    this.status = CreateCommentStatus.initial,
    this.error,
  });

  CreateCommentState copyWith({
    CreateCommentStatus? status,
    Exception? error,
  }) {
    return CreateCommentState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
