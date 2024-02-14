import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';
import 'package:xlike/app/auth/widgets/signup_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            Navigator.of(context).pushReplacementNamed('/post');
            break;
          case AuthStatus.error:
            _showSnackBar(context, 'Erreur');
            break;
            case AuthStatus.loading:
            _showSnackBar(context, 'Inscription en cours...');
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Inscription"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SignupForm(),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed(LoginScreen.routeName),
                child: const Text('Déjà un compte ? Connectez-vous'),
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
