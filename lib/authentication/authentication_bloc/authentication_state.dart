part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  loading,
  error,
}

class AuthenticationState {
  final AuthenticationStatus status;
  final User? user;
  final String? error;

  AuthenticationState({
    this.status = AuthenticationStatus.uninitialized,
    this.user,
    this.error,
  });

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    User? user,
    String? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
