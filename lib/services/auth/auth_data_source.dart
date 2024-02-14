
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/models/responses/login_response.dart';
import 'package:xlike/models/responses/signup_response.dart';
import 'package:xlike/models/domain/user.dart';

abstract class AuthDataSource {
  Future<SignupResponse> signup(SignupRequest request);

  Future<LoginResponse> login(LoginRequest request);

  Future<User> me();
}
