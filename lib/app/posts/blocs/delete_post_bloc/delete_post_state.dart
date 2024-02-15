part of 'delete_post_bloc.dart';

enum DeletePostStatus {
  initial,
  loading,
  success,
  error,
}

class DeletePostState {
  final DeletePostStatus status;
  final Exception? error;

  DeletePostState({
    this.status = DeletePostStatus.initial,
    this.error,
  });

  DeletePostState copyWith({
    DeletePostStatus? status,
    Exception? error,
  }) {
    return DeletePostState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
