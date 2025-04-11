import 'package:auth_firebase/models/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
    (ref) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance));

class AuthRepository {
  AuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> create(CurrentUser user) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final userId = userCredential.user!.uid;
      await _firestore
          .collection('users')
          .doc(userId)
          .set(user.copyWith(id: userId).toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String password) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    final uid = userCredential.user!.uid;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Błąd podczas wylogowywania: $e');
    }
  }

  Future<void> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
        await _firestore.collection('users').doc(user.uid).delete();
      }
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
