import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserAuth extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  String? _uid;
  String? _email;
  User? _user;

  String? get uid => _uid;
  String? get email => _email;
  User? get user => _user;

  UserAuth() {
    _user = _auth.currentUser;
    _uid = _auth.currentUser?.uid;
    _email = _auth.currentUser?.email;
    notifyListeners();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _uid = userCredential.user?.uid;
      _email = userCredential.user?.email;
      _user = userCredential.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _uid = userCredential.user?.uid;
      _email = userCredential.user?.email;
      _user = userCredential.user;
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
