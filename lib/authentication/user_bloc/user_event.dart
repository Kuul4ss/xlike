part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserSignupRequested extends UserEvent {
  final SignupRequest signupRequest;

  UserSignupRequested(this.signupRequest);
}

class UserLoginRequested extends UserEvent {
  final LoginRequest loginRequest;

  UserLoginRequested(this.loginRequest);
}

class UserInfoRequested extends UserEvent {
  final String authToken;

  UserInfoRequested(this.authToken);
}
