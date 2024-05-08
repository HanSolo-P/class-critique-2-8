import 'package:class_critique_app/exceptions/user_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  Future<String> createAccount(String email, String password, String fullName,
      String universityName) async {
      try {
        bool isEmailExist = await _checkUserExistsInFirestore(email); // check user if it exists in DB
        if(isEmailExist) {
          return 'Error: User already exists in Database';
        }
      } catch (e) {
        return '$e';
      }
    return await _createAccount(email, password, fullName, universityName);
  }

  Future<String> loginUser(String email, String password) async {
    return await _login(email, password);
  }

  Future<bool> _checkUserExistsInFirestore(String email) async {
    try {
    // Query all documents in the "users" collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();

    // Iterate through the documents and check the "email" field
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Check if the document's "email" field matches the given email
      if (doc.get('email') == email) {
        // User with the given email exists
        //print('email exists ***********');
        return true;
      }
    }

    // If no matching email is found in any document, the user does not exist
    return false;

    } catch (e) {
      print('Error checking user existence in Firestore: $e');
      throw 'Error checking user existence in Firestore: $e';
    }
  }

  Future<String> _createAccount(String email, String password, String fullName,
      String universityName) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Extract the user from the UserCredential
      User? user = userCredential.user;

      // Save user data to Firestore
      String message = await _saveUser(email, fullName, universityName);
      if (message.isEmpty) {
        // logout user if logged in
        throw UserSaveException('User not saved.');
      }

      print('User ${user!.email} created successfully');
      return 'Account created successfully';
    } on FirebaseAuthException catch (e) {
      String ex = 'Firebase Authentication Exception: ';
      if (e.code == 'email-already-in-use') {
        ex += ' the account already exists for that email';
      } else if (e.code == 'weak-password') {
        ex += 'the password provided is too weak';
      } else {
        ex += 'make sure you are using a valid email';
      }
      return ex;
    } on UserSaveException catch (e) {
      print('User Save Exception: ${e.message}');
      return 'User Save Exception: ${e.message}';
    } catch (e) {
      print('Exception: $e');
      return 'An error occurred while creating the account.';
    }
  }

  Future<String> _saveUser(
      String email, String fullName, String universityName) async {
    try {
      // Get the current user from Firebase Authentication
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is authenticated
      if (user != null) {
        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'universityName': universityName,
        });
        return 'User data saved successfully.';
      } else {
        throw UserSaveException('User not authenticated.');
      }
    } catch (e) {
      print('Error saving user data: $e');
      throw UserSaveException('An error occurred while saving user data: $e');
    }
  }

  Future<String> _login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Login successfully';
    } on FirebaseAuthException catch (e) {
      String ex = 'Firebase Authentication Exception: ';
      if (e.code == 'invalid-email') {
        ex += 'invalid email address';
      } else {
        ex += 'check your credentials and try signing in again';
      }
      return ex;
    }
  }
}
