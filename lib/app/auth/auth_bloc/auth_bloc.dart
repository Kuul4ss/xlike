import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/services/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<Signup>(_onSignup);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<VerifyToken>(_onVerifyToken);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.uninitialized));

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('authToken');
      if (token == null) {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      } else {
        User user = await authRepository.me();
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: Exception("L'utilisateur n'est pas connecté"),
      ));
    }
  }

  void _onSignup(Signup event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final response = await authRepository.signup(event.request);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', response.authToken);

      final User user = await authRepository.me();

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: Exception("Les credentials ne sont pas valide"),
      ));
    }
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final response = await authRepository.login(event.request);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('authToken', response.authToken);

      emit(state.copyWith(
        status: AuthStatus.authenticated,
        //user: user,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: AuthStatus.error,
        error: Exception("Les credentials ne sont pas valide"),
      ));
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('authToken');

    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
    ));
  }

  void _onVerifyToken(VerifyToken event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    if (token == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
    } else {
      try {
        final User user = await authRepository.me();
        emit(state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          error: Exception("Le token n'est pas valide"),
        ));
      }
    }
  }
}
