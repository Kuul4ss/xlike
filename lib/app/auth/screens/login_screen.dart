import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/screens/singup_screen.dart';
import '../widgets/login_form.dart';


class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.loading:
            Navigator.of(context).pushReplacementNamed('/post');
            break;
          case AuthStatus.error:
            _showSnackBar(context, 'Erreur de connexion');
            break;
          case AuthStatus.loading:
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
          child: Column(
            children: [
              LoginForm(),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(SignupScreen.routeName),
                child: Text('Pas de compte ? Inscrivez-vous'),
              ),
            ],
          ),
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
