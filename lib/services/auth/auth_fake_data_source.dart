import '../../models/domain/user.dart';
import '../../models/requests/login_request.dart';
import '../../models/requests/signup_request.dart';
import '../../models/responses/login_response.dart';
import '../../models/responses/signup_response.dart';
import 'auth_data_source.dart';

class FakeAuthDataSource extends AuthDataSource {
  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    await Future.delayed(const Duration(seconds: 1)); // Simuler un délai réseau
    return SignupResponse(
      authToken: 'fake_signup_auth_token',
      user: User(
        id: 1,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: request.name,
        email: request.email,
      ),
    );
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 1));
    return LoginResponse(
      authToken: 'fake_login_auth_token_for_${request.email}',
      user: User(
        id: 2,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: 'Utilisateur Connecté',
        email: request.email,
      ),
    );
  }

  @override
  Future<User> me() async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: 3,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      name: 'Utilisateur Authentifié',
      email: 'authenticated@example.com',
    );
  }
}
