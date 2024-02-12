import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:xlike/models/connected_user.dart';
import 'package:xlike/models/requests/signup_request.dart';
import '../../models/requests/login_request.dart';
import '../../models/user.dart';
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

  void _onUserLoginRequested(UserLoginRequested event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loginLoading));
    try {
      ConnectedUser connected_user = await userRepository.login(event.loginRequest);
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

