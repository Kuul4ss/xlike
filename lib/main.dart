import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/authentication/screens/singup_screen.dart';
import 'package:xlike/authentication/services/user_data_source.dart';
import 'package:xlike/authentication/user_bloc/user_bloc.dart';
import 'authentication/authentication_bloc/authentication_bloc.dart';
import 'authentication/screens/login_screen.dart';
import 'authentication/services/api_data_source.dart';
import 'authentication/services/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(userDataSource: ApiDataSource()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthenticationBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Votre App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                print("connecté");
                return LoginScreen();
              } else if (state.status == AuthenticationStatus.unauthenticated) {
                print("non connecté");
                return const LoginScreen();
              } else {
                print(state.status);
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
