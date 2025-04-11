import 'package:auth_firebase/extensions/string_extensions.dart';
import 'package:auth_firebase/models/current_user.dart';
import 'package:auth_firebase/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
              // TODO validacja
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'username'.toTranslate()),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'email'.toTranslate()),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: 'password'.toTranslate()),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_emailController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  error = 'Email and password is needed.'.toTranslate();
                  setState(() {});
                  return;
                }

                if (_usernameController.text.length < 3) {
                  error =
                      'Username must be at least 3 characters.'.toTranslate();
                  setState(() {});
                  return;
                }

                final CurrentUser user = CurrentUser(
                  _usernameController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  description: '',
                  createdAt: DateTime.now(),
                );

                final potentialError =
                    await ref.read(authRepositoryProvider).create(user);
                if (potentialError != null) {
                  error = potentialError.toTranslate();
                  setState(() {});
                }
              },
              child: Text('registration'.toTranslate()),
            ),
          ],
        ),
      ),
    );
  }
}
