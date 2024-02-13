import 'package:xlike/models/user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';

import '../../models/connected_user.dart';

abstract class UserDataSource {
  Future<ConnectedUser> login(LoginRequest loginRequest);
  Future<ConnectedUser> signup(SignupRequest signupRequest);
  Future<User> me(String authToken);
}
