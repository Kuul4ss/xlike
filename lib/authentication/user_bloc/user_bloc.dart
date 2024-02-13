import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlike/models/domain/connected_user.dart';
import 'package:xlike/models/domain/user.dart';
import 'package:xlike/models/requests/signup_request.dart';
import '../../models/requests/login_request.dart';
import '../services/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState()) {
    on<UserSignupRequested>(_onUserSignupRequested);
    on<UserLoginRequested>(_onUserLoginRequested);
    on<UserInfoRequested>(_onUserInfoRequested);
  }

  void _onUserSignupRequested(UserSignupRequested event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.signupLoading));
    try {
      ConnectedUser connected_user = await userRepository.signup(event.signupRequest);
      saveUserData(connected_user.authToken, connected_user.user.id.toString());
      emit(state.copyWith(
        status: UserStatus.signupSuccess,
        connected_user: connected_user,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: UserStatus.error,
        error: error.toString(),
      ));
    }
  }

  Future<void> saveUserData(String authToken,String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', authToken);
    await prefs.setString('id', id);
  }


  void _onUserLoginRequested(UserLoginRequested event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loginLoading));
    try {
      ConnectedUser connected_user = await userRepository.login(event.loginRequest);
      saveUserData(connected_user.authToken,connected_user.user.id.toString());
      emit(state.copyWith(
        status: UserStatus.loginSuccess,
        connected_user: connected_user
      ));
    } catch (error) {
      emit(state.copyWith(
        status: UserStatus.error,
        error: error.toString(),
      ));
    }
  }

  void _onUserInfoRequested(UserInfoRequested event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loginLoading));
    try {
      User? user = await userRepository.me(event.authToken);
      emit(state.copyWith(
        status: UserStatus.loginSuccess,
        user: user,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: UserStatus.error,
        error: error.toString(),
      ));
    }
  }
}

