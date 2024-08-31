import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parul_seminar/app/string_extensions.dart';
import 'package:parul_seminar/screen/sign_in_screen/sign_in_screen.dart';

class AuthenticationService {
  AuthenticationService._privateConstructor();

  static final AuthenticationService instance = AuthenticationService._privateConstructor();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        'The email address is badly formatted.'.showToast(context);
      } else if (e.code == 'weak-password') {
        'The password provided is too weak.'.showToast(context);
      } else if (e.code == 'email-already-in-use') {
        'The account already exists for that email.'.showToast(context);
      }
    } on FirebaseException catch (e) {
      'Catch exception in signUpWithEmailPassword --> ${e.message}'.logs();
    }
    return null;
  }

  Future<User?> verifyUserWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      'e.code --> ${e.code}'.logs();
      if (e.code == 'invalid-credential') {
        'Invalid credential.'.showToast(context);
      } else if (e.code == 'user-not-found') {
        'No user found for that email.'.showToast(context);
      } else if (e.code == 'wrong-password') {
        'Wrong password provided for that user.'.showToast(context);
      }
    } on FirebaseException catch (e) {
      'Catch exception in verifyUserWithEmailPassword --> ${e.message}'.logs();
    }
    return null;
  }

  Future<void> signOut(context) async {
    await _firebaseAuth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    'Logout successfully'.showToast(context);
  }
}
