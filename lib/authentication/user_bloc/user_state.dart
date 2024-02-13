part of 'user_bloc.dart';

enum UserStatus {
  initial,
  signupLoading,
  signupSuccess,
  loginLoading,
  loginSuccess,
  infoLoading,
  infoSuccess,
  error,
}

class UserState {
  final UserStatus status;
  final User? user;
  final ConnectedUser? connected_user;
  final String? error;

  UserState({
    this.status = UserStatus.initial,
    this.user,
    this.connected_user,
    this.error,
  });

  UserState copyWith({
    UserStatus? status,
    User? user,
    ConnectedUser? connected_user,
    String? error,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      connected_user: connected_user ?? this.connected_user,
      error: error ?? this.error,
    );
  }
}
