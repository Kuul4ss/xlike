import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../user_bloc/user_bloc.dart';
import '../widgets/signup_form.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        switch (state.status) {
          case UserStatus.signupSuccess:
            Navigator.of(context).pushReplacementNamed('/post'); // Remplacez '/postPage' par le nom de la route de votre page post-connexion.
            break;
          case UserStatus.error:
            _showSnackBar(context, 'Erreur');
            break;
            case UserStatus.signupLoading:
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
