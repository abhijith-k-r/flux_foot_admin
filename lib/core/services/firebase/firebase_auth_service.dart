import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, String>?> fetchAdminCredentials() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('admin_credentials')
          .doc('default_admin')
          .get();

      if (doc.exists) {
        return {
          'email': doc['email'] as String,
          'password': doc['password'] as String,
        };
      }
      return null;
    } catch (e) {
      throw Exception('Error fetchin admin credential : $e');
    }
  }

  // ! SignOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
