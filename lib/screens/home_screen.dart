import 'package:auth_firebase/extensions/string_extensions.dart';
import 'package:auth_firebase/models/current_user.dart';
import 'package:auth_firebase/providers/current_user_stream_provider.dart';
import 'package:auth_firebase/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userStreamProvider);

    final userWidget = userData.when(
      data: (userData) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            child: Image.network(userData!.imageUrl ?? emptyProfilePic),
          ),
          Text(userData.username)
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        return const Placeholder();
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            userWidget,
            ElevatedButton(
                onPressed: () {
                  ref.read(authRepositoryProvider).logout();
                },
                child: Text('logout'.toTranslate())),
            ElevatedButton(
                onPressed: () {
                  ref.read(authRepositoryProvider).deleteUser();
                },
                child: Text('delete profile'.toTranslate())),
          ],
        ),
      ),
    );
  }
}
