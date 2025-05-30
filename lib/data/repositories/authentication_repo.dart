import 'package:arilo_admin/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }

 void screenRedirect() async {
  final user = _auth.currentUser;

  if (user != null) {
    Get.offAllNamed(AriloRoute.dashboard);
  } else {
    Get.offAllNamed(AriloRoute.login);
  }
}

  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found with this email';
      } else if (e.code == 'wrong-password') {
        throw 'Incorrect password';
      } else {
        throw 'Login failed: ${e.message}';
      }
    } catch (e) {
      throw 'Login failed. Please try again';
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'Password is too weak';
      } else if (e.code == 'email-already-in-use') {
        throw 'Email is already registered';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address';
      } else {
        throw 'Registration failed: ${e.message}';
      }
    } catch (e) {
      throw 'Registration failed. Please try again';
    }
  }
  

  Future<void> sendPasswordResetEmail(String email) async {
    try {
        await _auth.sendPasswordResetEmail(email: email);
     } on FirebaseAuthException catch (e) {
      throw 'Authentication error: ${e.message}';
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
        throw 'Something went wrong. Please try again';
    }
}






  Future<void> logout() async {
    try {
        await FirebaseAuth.instance.signOut();
        Get.offAllNamed(AriloRoute.login);
    } on FirebaseAuthException catch (e) {
      throw 'Authentication error: ${e.message}';
    } on FirebaseException catch (e) {
      throw 'Firestore error: ${e.message}';
    } on FormatException catch (_) {
      throw 'Invalid data format';
    } on PlatformException catch (e) {
      throw 'Platform error: ${e.message}';
    } catch (e) {
      throw 'Something went wrong: $e';
    }
}
}
