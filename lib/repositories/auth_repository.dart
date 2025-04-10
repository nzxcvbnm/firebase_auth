import 'package:auth_firebase/models/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> create(CurrentUser user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      }
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      throw Exception('Error deleting user: $e');
    }
  }
}
