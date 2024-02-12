import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication_bloc/authentication_bloc.dart';
import '../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthenticationStatus.authenticated:
            Navigator.of(context).pushReplacementNamed('/postPage'); // Remplacez '/postPage' par le nom de la route de votre page post-connexion.
            break;
          case AuthenticationStatus.error:
            _showSnackBar(context, 'Erreur de connexion');
            break;
          case AuthenticationStatus.loading:
            _showSnackBar(context, 'Connexion en cours...');
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
          child: SignupForm(),
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
