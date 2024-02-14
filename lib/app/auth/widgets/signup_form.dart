import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xlike/models/requests/signup_request.dart';
import 'package:xlike/app/auth/auth_bloc/auth_bloc.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'name'),
                controller: _nameController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'email'),
                controller: _emailController,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'mot de passe'),
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (state.status != AuthStatus.loading) {
                    SignupRequest signupRequest = SignupRequest(
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _nameController.text,
                    );
                    context
                        .read<AuthBloc>()
                        .add(Signup(signupRequest));
                  }
                },
                child: state.status == AuthStatus.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("S'inscrire"),
              ),
            ],
          ),
        );
      },
    );
  }
}
