import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Firebase_Operations.dart';

class Authentification {
  final FirebaseAuth _firebaseAuth;
  FirestoreOperations db = new FirestoreOperations();
  Authentification(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> getUserID() async {
    final User user = _firebaseAuth.currentUser;
    return user.uid;
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  createNewUser({
    String email,
    String password,
    String userName,
    String dropdownValue,
    DateTime selectedDate,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "$email", password: "$password").whenComplete(
        () {
          getUserID().then(
            (value) => db.addUserToDB(
              userID: value,
              userName: userName,
              dateOfBirth: selectedDate,
              gender: dropdownValue,
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
