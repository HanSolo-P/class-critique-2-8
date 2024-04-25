import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


class AuthService {

  Future<String> createAccount(String email, String password) async {
    return await _createAccount(email, password);
  }

  Future<String> loginUser(String email, String password) async {
    return await _login(email, password);
  }

  Future<String> _createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((firebaseUser){
        if(kDebugMode){
          print('User: ${firebaseUser.user!.email} created successfully');
        }
      });
      return 'Account created successfully';
    } on FirebaseAuthException catch(e){
      String ex = 'Firebase Authentication Exception: ';
      if(e.code == 'email-already-in-use'){
        ex += ' the account already exists for that email';
      } else if(e.code == 'weak-password'){
        ex += 'the password provided is too weak';
      } else {
        ex += 'make sure you are using a valid email';
      }
      return ex;
    }
  }

  Future<String> _login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Login successfully';

    } on FirebaseAuthException catch(e){
      String ex = 'Firebase Authentication Exception: ';
      if(e.code == 'invalid-email'){
        ex += 'invalid email address';
      } else {
        ex += 'check your credentials and try signing in again';
      }
      return ex;
    }
  }


  
}