import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  AuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final AuthService instance = AuthService._();

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error signing in: ${e.message}");
      rethrow;
    }
    return null;
  }

  Future<User?> signUp(String username, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(username);

        await userCredential.user!.reload();

        return _auth.currentUser;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error signing up: ${e.message}");
      rethrow;
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint("Error signing out: ${e.message}");
      rethrow;
    }
  }
}
