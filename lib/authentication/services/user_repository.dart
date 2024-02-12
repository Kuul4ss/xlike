import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlike/authentication/services/user_data_source.dart';
import 'package:xlike/models/connected_user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';

import '../../models/user.dart';

class UserRepository {

final UserDataSource userDataSource;

UserRepository({required this.userDataSource});

  Future<ConnectedUser> signup(SignupRequest signupRequest) async {
    return userDataSource.signup(signupRequest);
      }

  Future<ConnectedUser> login(LoginRequest loginRequest) async {
    return userDataSource.login(loginRequest);
  }

  Future<User?> me(String auhtToken) async {
    return userDataSource.me(auhtToken);
  }

Future<void> saveToken(String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('authToken', token);
}


Future<void> deleteToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken');
}

}
