import 'package:dio/dio.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/models/responses/login_response.dart';
import 'package:xlike/models/responses/signup_response.dart';
import 'package:xlike/services/client/dio_client.dart';

import 'auth_data_source.dart';

class AuthApiDataSource extends AuthDataSource {
  final DioClient dioClient;
  final String routePrefix = "/auth";

  AuthApiDataSource({required this.dioClient});

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    try {
      Response response = await dioClient.dio.post(
        '$routePrefix/signup',
        data: request.toJson(),
      );
      final jsonElement = response.data;
      return SignupResponse.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      Response response = await dioClient.dio.post(
        '$routePrefix/login',
        data: request.toJson(),
      );
      final jsonElement = response.data;
      return LoginResponse.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> me() async {
    try {
      Response response = await dioClient.dio.get(
        '$routePrefix/me',
      );
      final jsonElement = response.data;
      return User.fromJson(jsonElement as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }
}
