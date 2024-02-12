import 'dart:ffi';

import 'package:xlike/models/user.dart';

class ConnectedUser {
  final String token;
  final User user;


  const ConnectedUser({
    required this.token,
    required this.user
  });

  factory ConnectedUser.fromJson(Map<String, dynamic> json) {
    return ConnectedUser(
      token: json['authToken'],
      user:  User.fromJson(json['user']),
    );
  }
}
