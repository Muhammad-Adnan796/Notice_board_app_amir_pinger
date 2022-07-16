import 'package:auth_firebase_amir_pinger/constants/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class AuthClass {
  Future<void> createuser(String email, String password);
  Future<void> login(String email, String password);
  Future<void> signout();

  User? get currentUser;
}

class Authservice extends AuthClass {
  static final Authservice instance = Authservice();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  factory Authservice() {
    return instance;
  }

  
  // Authservice._internal() {
  //   // This method could be use to set initial values if any.
  // }

  @override
  Future<User?> createuser(String email, String password) async {
    try {
      final respnse = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (respnse.user == null) {
        throw Exception(ErrorStrings.userCreationFailed);
      }
      return respnse.user;
    } catch (e) {
      debugPrint("${ErrorStrings.userCreationFailed} $e");
      rethrow;
    }
  }

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (response.user == null) {
        throw Exception(ErrorStrings.loginError);
      }
      return response.user;
    } catch (e) {
      debugPrint("${ErrorStrings.loginError} $e");
      rethrow;
    }
  }

  @override
  Future<void> signout() async {
    await _auth.signOut();
  }
}
