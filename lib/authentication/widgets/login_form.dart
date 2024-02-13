import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/authentication/user_bloc/user_bloc.dart';
import 'package:xlike/models/requests/signup_request.dart';
import '../../models/requests/login_request.dart';
import '../authentication_bloc/authentication_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.loginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Connexion réussie!')),
          );
        } else if (state.status == UserStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur de connexion: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        String message = '';
        if (state.status == UserStatus.loginLoading) {
          message = 'Connexion en cours...';
        } else if (state.status == UserStatus.loginSuccess) {
          message = 'Connexion réussie!';
        } else if (state.status == UserStatus.error) {
          message = 'Erreur de connexion';
        }

        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: _emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (state.status != UserStatus.loginLoading) {
                    LoginRequest loginRequest = LoginRequest(email: _emailController.text, password: _passwordController.text);
                    context.read<UserBloc>().add(UserLoginRequested(loginRequest));
                  }
                },
                child: state.status == UserStatus.loginLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Se connecter'),
              ),
              const SizedBox(height: 20),
              Text(message), // Affiche le message en fonction de l'état
            ],
          ),
        );
      },
    );
  }
}
