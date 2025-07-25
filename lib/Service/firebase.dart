import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platio/Model/menuItem.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class FireAuth {
  Future<String?> registerWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // ✅ Update display name
      await userCredential.user!.updateDisplayName(username);

      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e.code);
    } catch (e) {
      return "Registration failed. Please try again.";
    }
  }

  Future<String?> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e.code);
    } catch (e) {
      return "Login failed. Please try again.";
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  String _handleAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return "Invalid email format.";
      case 'weak-password':
        return "Password is too weak.";
      case 'email-already-in-use':
        return "Email is already registered.";
      case 'network-request-failed':
        return "No internet connection.";
      case 'user-not-found':
        return "User not found.";
      case 'wrong-password':
      case 'INVALID_LOGIN_CREDENTIALS':
      case 'invalid-credential':
        return "Wrong email or password.";
      default:
        return "Authentication failed.";
    }
  }
}

class FireStore {
  final String collectionName = 'menu';

  Future<List<menuItem_Model>> getMenuItems() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(collectionName).get();

      return snapshot.docs
          .map((doc) => menuItem_Model.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching menu: $e');
      return [];
    }
  }
}
