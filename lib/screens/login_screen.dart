import 'package:auth_firebase/extensions/string_extensions.dart';
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

  String? error = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (error != '') Text(error!),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: 'email'.toTranslate())),
            TextField(
                controller: _passwordController,
                decoration:
                    InputDecoration(hintText: 'password'.toTranslate())),
            ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    error = 'Email and password is needed.'.toTranslate();
                    setState(() {});
                    return;
                  }

                  final potentialError = await ref
                      .read(authRepositoryProvider)
                      .login(_emailController.text.trim(),
                          _passwordController.text.trim());

                  if (potentialError != null) {
                    error = potentialError;
                    setState(() {});
                  }
                },
                child: Text('login'.toTranslate())),
            ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isEmpty) {
                    error = 'Email is needed.'.toTranslate();
                    setState(() {});
                    return;
                  }

                  final potentialError = await ref
                      .read(authRepositoryProvider)
                      .sendPasswordResetEmail(_emailController.text.trim());

                  if (potentialError != null) {
                    error = potentialError;
                    setState(() {});
                  } else {
                    error = 'Reset email password was sent'.toTranslate();
                    setState(() {});
                  }
                },
                child: Text('reset password'.toTranslate())),
          ],
        ),
      ),
    );
  }
}
