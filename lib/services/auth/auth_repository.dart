import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/models/responses/login_response.dart';
import 'package:xlike/models/responses/signup_response.dart';
import 'package:xlike/services/auth/auth_data_source.dart';

class AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<SignupResponse> signup(SignupRequest request) {
    return authDataSource.signup(request);
  }

  Future<LoginResponse> login(LoginRequest request) {
    return authDataSource.login(request);
  }

  Future<User> me() {
    return authDataSource.me();
  }
}
