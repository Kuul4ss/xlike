import 'dart:ffi';

import 'package:xlike/models/user.dart';

class ConnectedUser {
  final String authToken;
  final User user;


  const ConnectedUser({
    required this.authToken,
    required this.user
  });

  factory ConnectedUser.fromJson(Map<String, dynamic> json) {
    return ConnectedUser(
      authToken: json['authToken'],
      user:  User.fromJson(json['user']),
    );
  }
}
