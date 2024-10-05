import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_with_bloc/features/product/presentation/pages/product_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Handle successful login, navigate to the next screen
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.user.email ??
                    "no user found"))); 
                    
            // Adjust route as needed

            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const ProductScreen()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  // Dispatch login event
                  context
                      .read<AuthBloc>()
                      .add(LoginEvent(email: email, password: password));
                },
                child: const Text('Login'),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  }
                  return const SizedBox.shrink(); // Empty widget if not loading
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
