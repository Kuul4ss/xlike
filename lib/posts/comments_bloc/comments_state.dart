part of 'comments_bloc.dart';

enum CommentsStatus {
  initial,
  addingComment,
  success,
  error,
}

class CommentsState {
  final CommentsStatus status;
  final Exception? error;

  CommentsState({
    this.status = CommentsStatus.initial,
    this.error,
  });

  CommentsState copyWith({
    CommentsStatus? status,
    Exception? error,
  }) {
    return CommentsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
