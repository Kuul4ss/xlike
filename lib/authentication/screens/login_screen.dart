import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlike/authentication/user_bloc/user_bloc.dart';
import '../authentication_bloc/authentication_bloc.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {

        switch (state.status) {

          case UserStatus.loginSuccess:
            Navigator.of(context).pushReplacementNamed('/post');
            print(SharedPreferences.getInstance());
            break;
          case UserStatus.error:
            _showSnackBar(context, 'Erreur de connexion');
            break;
          case UserStatus.loginLoading:
            _showSnackBar(context, 'Connexion en cours...');
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Connexion'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: LoginForm(),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
