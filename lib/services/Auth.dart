import 'dart:async';
import 'package:SocialSurveys/services/UserService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signin(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password
    );
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> createUser(String name, String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password
    );
    FirebaseUser user = result.user;
    String userId = user.uid;
    await UserService.instance.addUser(userId, email, name);
    return userId;
  }

  Future<FirebaseUser> getUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signout() async {
    return _firebaseAuth.signOut();
  }
}