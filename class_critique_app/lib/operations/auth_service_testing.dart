import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class AuthService {

  final FirebaseAuth _auth;

  AuthService({required FirebaseAuth auth}) : _auth = auth;

  Future<UserCredential?> createAccount(String email, String password) async {
    return await _createAccount(email, password);
  }

  Future<UserCredential?> loginUser(String email, String password) async {
    return await _login(email, password);
  }

  Future<UserCredential?> _createAccount(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((firebaseUser){
        if(kDebugMode){
          print('User: ${firebaseUser.user!.email} created successfully');
        }
        return firebaseUser;
      });
    } on FirebaseAuthException catch(e){
      String ex = 'Firebase Authentication Exception: ';
      if(e.code == 'email-already-in-use'){
        ex += ' the account already exists for that email';
      } else if(e.code == 'weak-password'){
        ex += 'the password provided is too weak';
      } else {
        ex += 'make sure you are using a valid email';
      }
      throw ex;
      //userCredential = null;
    }

    return userCredential;
  }

  Future<UserCredential?> _login(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((firebaseUser){
        if(kDebugMode){
          print('User: ${firebaseUser.user!.email} logged in successfully');
        }
        return firebaseUser;
      });
    } on FirebaseAuthException catch(e){
      String ex = 'Firebase Authentication Exception: ';
      if(e.code == 'invalid-email'){
        ex += 'invalid email address';
      } else {
        ex += 'check your credentials and try signing in again';
      }
      print('Exception: $ex');
      throw ex;
    }

    return userCredential;
  }

}