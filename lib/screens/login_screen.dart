import 'package:auth_firebase/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'email')),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'password')),
            ElevatedButton(
                onPressed: () {
                  ref.read(authRepositoryProvider).login(
                      _emailController.text.trim(),
                      _passwordController.text.trim());
                },
                child: const Text('login'))
          ],
        ),
      ),
    );
  }
}
