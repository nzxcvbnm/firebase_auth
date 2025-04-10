import 'package:auth_firebase/providers/have_account_provider.dart';
import 'package:auth_firebase/screens/login_screen.dart';
import 'package:auth_firebase/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool haveAccount = ref.watch(haveAccountProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('do you have an account?'),
        actions: [
          Switch(
            value: haveAccount,
            onChanged: (value) =>
                ref.read(haveAccountProvider.notifier).state = value,
          )
        ],
      ),
      body: haveAccount ? const LoginScreen() : const RegistrationScreen(),
    );
  }
}
