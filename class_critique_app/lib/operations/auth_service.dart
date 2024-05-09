import 'package:class_critique_app/exceptions/user_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _database;

  AuthService({required FirebaseAuth auth, required FirebaseFirestore database})
      : _auth = auth,
        _database = database;

  Future<String> performSignup(String email, String password, String fullName,
      String universityName) async {
    //print('******* Step 1: performSignup called');
    try {
      bool doesUserExist = await checkUserExistsInFirestore(email);
      if (doesUserExist) {
        //print('***** Error performSignup: doesUserExist');
        throw UserSaveException('User already exists.');
      }

      UserCredential? userCredential =
          await _createAccount(email, password, fullName, universityName);

      if (userCredential != null) {
        //print('******* Step 5: userCredential != null');
        String message = await saveUser(email, fullName, universityName);
        return message;
      } else {
        throw 'User not Created';
      }
    } on UserSaveException catch (e) {
      print('User Save Exception: ${e.message}');
      return 'Error: ${e.message}';
    } catch (e) {
      print('Error : $e');
      return 'Error: $e';
    }
  }

  Future<String> performLogin(String email, String password) async {
    try {
      UserCredential? userCredential = await _login(email, password);

      if (userCredential != null) {
        if (kDebugMode) {
          print('User: ${userCredential.user!.email} logged in successfully');
        }
        return 'User: ${userCredential.user!.email} logged in successfully';
      } else {
        throw 'userCredential is null';
      }
    } catch (e) {
      print('Error : $e');
      return 'Error: $e';
    }
  }

  Future<UserCredential?> createAccount(String email, String password,
      String fullName, String universityName) async {
    return await _createAccount(email, password, fullName, universityName);
  }

  Future<UserCredential?> loginUser(String email, String password) async {
    return await _login(email, password);
  }

  Future<String> saveUser(
      String email, String fullName, String universityName) async {
    //print('******* Step 6: saveUser called');
    // Save user data to Firestore
    return await _saveUser(email, fullName, universityName);
  }

  Future<bool> checkUserExistsInFirestore(String email) async {
    //print('******* Step 2: checkUserExistsInFirestore called');
    return await _checkUserExistsInFirestore(
        email); // check user if it exists in DB
  }

  Future<bool> _checkUserExistsInFirestore(String email) async {
    //print('******* Step 3: _checkUserExistsInFirestore called');
    try {
      // Query all documents in the "users" collection
      QuerySnapshot querySnapshot = await _database.collection('users').get();

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

  Future<UserCredential?> _createAccount(String email, String password,
      String fullName, String universityName) async {
    //print('******* Step 4: _createAccount called');
    UserCredential? userCredential;
    try {
      // Create user with email and password
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Extract the user from the UserCredential
      User? user = userCredential.user;

      print('User ${user!.email} created successfully');
      // return 'Account created successfully';
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String ex = 'Firebase Authentication Exception: ';
      if (e.code == 'email-already-in-use') {
        ex += ' the account already exists for that email';
      } else if (e.code == 'weak-password') {
        ex += 'the password provided is too weak';
      } else {
        ex += 'make sure you are using a valid email';
      }
      throw ex;
    } on UserSaveException catch (e) {
      print('User Save Exception: ${e.message}');
      throw 'User Save Exception: ${e.message}';
    } catch (e) {
      print('Exception: $e');
      throw 'An error occurred while creating the account.';
    }
  }

  Future<String> _saveUser(
      String email, String fullName, String universityName) async {
    //print('_saveUser ${_auth.currentUser}');
    try {
      // Get the current user from Firebase Authentication
      User? user =
          _auth.currentUser; // TODO: it can create error during testing

      // Check if the user is authenticated
      if (user != null) {
        // Save user data to Firestore
        //print('******* Step 7: user != null and Saving user');

        await _database.collection('users').doc(user.uid).set({
          'email': email,
          'fullName': fullName,
          'universityName': universityName,
        });
        return 'User data saved successfully.';
      } else {
        throw 'User not authenticated.';
      }
    } catch (e) {
      print('Error saving user data: $e');
      throw UserSaveException('An error occurred while saving user data: $e');
    }
  }

  Future<UserCredential?> _login(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((firebaseUser) {
        return firebaseUser;
      });
    } on FirebaseAuthException catch (e) {
      String ex = 'Firebase Authentication Exception: ';
      if (e.code == 'invalid-email') {
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