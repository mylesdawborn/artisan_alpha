import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

//Firebase connection/signins/user creation all moved into separate class below.

abstract class BaseAuth {
  //abstract class separates concerns and makes signin modular. Generic sign in method.
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  //uses firebase but can be changed without breaking code. Uses BaseAuth variables.
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //cleaner code
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> currentUser() async {
    //checks if user is logged in and returns userid == displays home page, else returns null == displays login screen
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
