import 'package:auth_firebase/models/current_user.dart';
import 'package:auth_firebase/providers/auth_state_provider.dart';
import 'package:auth_firebase/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final userIdStreamProvider = Provider<String?>((ref) {
//   final auth = ref.watch(authStateProvider).value;
//   return auth?.uid;
// });

final userStreamProvider = StreamProvider<CurrentUser?>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId != null) {
    return ref.watch(userRepositoryProvider).streamUserByI(userId);
  }
  return Stream.value(null); // Jeśli użytkownik nie jest zalogowany
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});
