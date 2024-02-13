import 'package:xlike/models/domain/user.dart';

class LoginResponse {
  final String authToken;
  final User user;

  const LoginResponse({
    required this.authToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      authToken: json['authToken'],
      user: User.fromJson(json['user']),
    );
  }
}