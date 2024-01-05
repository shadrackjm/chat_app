import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // instance of firestore
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // sign in user
  Future<UserCredential> singWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCrediantial =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // after the user also create user document in the firestore.. user collection
      _firebaseFirestore
          .collection('users')
          .doc(userCrediantial.user!.uid)
          .set({
        'uid': userCrediantial.user!.uid,
        'email': userCrediantial.user!.email,
      }, SetOptions(merge: true));
      return userCrediantial;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign in user
  Future<UserCredential> singUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCrediantial = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // after the user also create user document in the firestore.. user collection
      _firebaseFirestore
          .collection('users')
          .doc(userCrediantial.user!.uid)
          .set({
        'uid': userCrediantial.user!.uid,
        'email': userCrediantial.user!.email,
      });
      return userCrediantial;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signout
  Future<void> signOut() async {
   return await FirebaseAuth.instance.signOut();
  }
}
