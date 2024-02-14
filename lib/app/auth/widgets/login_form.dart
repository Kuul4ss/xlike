import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/requests/login_request.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connexion réussie!'),
            ),
          );
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur de connexion: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        String message = '';
        if (state.status == AuthStatus.loading) {
          message = 'Connexion en cours...';
        } else if (state.status == AuthStatus.authenticated) {
          message = 'Connexion réussie!';
        } else if (state.status == AuthStatus.error) {
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
                onPressed: () => _onLoginButtonPressed,
                child: state.status == AuthStatus.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Se connecter'),
              ),
              const SizedBox(height: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  void _onLoginButtonPressed(context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state.status != AuthStatus.loading) {
      LoginRequest loginRequest = LoginRequest(
        email: _emailController.text,
        password: _passwordController.text,
      );
      context
          .read<AuthBloc>()
          .add(Login(loginRequest));
    }
  }
}
