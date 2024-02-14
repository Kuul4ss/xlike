part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class Signup extends AuthEvent {
  final SignupRequest request;

  Signup(this.request);
}

class Login extends AuthEvent {
  final LoginRequest request;

  Login(this.request);
}

class Logout extends AuthEvent {}

class VerifyToken extends AuthEvent {}
