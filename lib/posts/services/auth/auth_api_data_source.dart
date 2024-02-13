
import 'package:dio/dio.dart';

import 'package:xlike/models/domain/comment.dart';
import 'package:xlike/models/requests/create_comment_request.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/models/responses/login_response.dart';
import 'package:xlike/models/responses/signup_response.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/posts/services/comments/comments_data_source.dart';

import 'auth_data_source.dart';

class AuthApiDataSource extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://xoc1-kd2t-7p9b.n7c.xano.io/api:xbcc5VEi',
    ),
  );

  @override
  Future<LoginResponse> login(LoginRequest request) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> me() {
    // TODO: implement me
    throw UnimplementedError();
  }

  @override
  Future<SignupResponse> signup(SignupRequest request) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
