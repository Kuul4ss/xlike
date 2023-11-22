import 'dart:ffi';

class ConnectedUser {
  final Int id;
  final DateTime createdAt;
  final String name;
  final String email;


  const ConnectedUser({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.email
  });

  factory ConnectedUser.fromJson(Map<String, dynamic> json) {
    return ConnectedUser(
      id: json['id'],
      createdAt: json['created_at'],
      name: json['name'],
      email: json['email'],
    );
  }
}
