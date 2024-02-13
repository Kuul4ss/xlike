import 'package:dio/dio.dart';
import 'package:xlike/authentication/services/user_data_source.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/models/user.dart';

import '../../models/connected_user.dart';
import '../../models/requests/login_request.dart';

class UserApiDataSource extends UserDataSource {

  final dio = Dio(
  BaseOptions(
    baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi/auth',
  ),
);

@override
  Future<ConnectedUser> login(LoginRequest loginRequest) async {

    try {
      final response = await dio.post('/login',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {'email': loginRequest.email, 'password': loginRequest.password});
      return ConnectedUser.fromJson(response.data);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<ConnectedUser> signup(SignupRequest signupRequest) async {
    try {
      final response = await dio.post('/signup',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: {'email': signupRequest.email, 'name': signupRequest.name, 'password': signupRequest.password});
      return ConnectedUser.fromJson(response.data);
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  @override
  Future<User> me(String authToken) async {
    try {
      final response = await dio.get('/me',
        options: Options(headers: {'Authorization': 'Bearer $authToken'},
        ),
      );
      return User.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
