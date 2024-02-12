part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;

  AuthenticationStatusChanged({required this.status});
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  String authToken;
  LoggedIn(this.authToken);
}

class LoggedOut extends AuthenticationEvent {}

class VerifyToken extends AuthenticationEvent {}