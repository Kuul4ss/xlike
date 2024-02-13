import 'package:xlike/models/domain/user.dart';

class SignupResponse {
  final String authToken;
  final User user;

  const SignupResponse({
    required this.authToken,
    required this.user,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      authToken: json['authToken'],
      user: User.fromJson(json['user']),
    );
  }
}