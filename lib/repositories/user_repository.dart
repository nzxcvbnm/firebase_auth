import 'package:auth_firebase/models/current_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  UserRepository(this._auth, this._firestore);

  Future<void> create(CurrentUser user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<CurrentUser?> getUserById(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        return CurrentUser.fromMap(userDoc.data()!);
      }
    } catch (e) {
      print("Error getting user: $e");
    }
    return null;
  }

  Stream<CurrentUser> streamUserByI(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) => CurrentUser.fromMap(doc.data()!));
  }

  Future<void> updateUser(CurrentUser user) async {
    await _firestore.collection('users').doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // na potem
  // Future<void> toggleFavorite(String uid, String listingId) async {
  //   final userDoc = _firestore.collection('users').doc(uid);
  //   final snapshot = await userDoc.get();
  //   final data = snapshot.data();
  //   final List<dynamic> favorites = data?['favorites'] ?? [];

  //   if (favorites.contains(listingId)) {
  //     await userDoc.update({
  //       'favorites': FieldValue.arrayRemove([listingId]),
  //     });
  //   } else {
  //     await userDoc.update({
  //       'favorites': FieldValue.arrayUnion([listingId]),
  //     });
  //   }
  // }
}
