import 'package:auth_firebase/providers/current_user_stream_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userStreamProvider);

    final userWidget = userData.when(
      data: (userData) => Row(
        children: [
          CircleAvatar(
            child: Image.network(userData!.imageUrl),
          ),
          Text(userData.username)
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Placeholder(),
    );

    return Scaffold(
      body: Column(
        children: [
          userWidget,
          ElevatedButton(onPressed: () {}, child: const Text('logout')),
        ],
      ),
    );
  }
}
