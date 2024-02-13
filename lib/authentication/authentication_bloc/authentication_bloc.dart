import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import '../services/user_repository.dart';



part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({required this.userRepository}) : super(AuthenticationState()) {

    on<AppStarted>((event, Emitter<AuthenticationState> emit) async {
      emit(state.copyWith(status: AuthenticationStatus.uninitialized));
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('authToken');
        if (token == null) {
          emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
        }else{
        User? user = await userRepository.me(token);
        emit(state.copyWith(
          status: AuthenticationStatus.authenticated,
          user: user,
        ));
        }
      } catch (error) {
        emit(state.copyWith(
          status: AuthenticationStatus.unauthenticated,
          error: error.toString(),
        ));
      }
    });

    on<LoggedIn>((event, emit) async {
      emit(state.copyWith(status: AuthenticationStatus.authenticated,));
    });

    on<LoggedOut>((event, emit) async {
      await userRepository.deleteToken();
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
    });

    on<VerifyToken>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('authToken');
      if (token == null) {
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
      }else{
      final User? user = await userRepository.me(token);
      if (user == null) {
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
      }else{
        emit(state.copyWith(
          status: AuthenticationStatus.authenticated,
          user: user,
        ));
      }
      }
    });
  }
}
