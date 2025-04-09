import 'package:auth_firebase/providers/auth_state_provider.dart';
import 'package:auth_firebase/screens/auth_screen.dart';
import 'package:auth_firebase/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MaterialApp(home: MainApp())));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
        data: (user) {
          if (user == null) return const AuthScreen();
          return const HomeScreen();
        },
        error: (e, s) => const Placeholder(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
