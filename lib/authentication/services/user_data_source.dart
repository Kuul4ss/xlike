import 'package:xlike/models/domain/connected_user.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';

abstract class UserDataSource {
  Future<ConnectedUser> login(LoginRequest loginRequest);
  Future<ConnectedUser> signup(SignupRequest signupRequest);
  Future<User> me(String authToken);
}
