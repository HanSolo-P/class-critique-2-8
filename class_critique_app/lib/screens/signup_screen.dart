// ignore_for_file: prefer_const_constructors

import 'package:class_critique_app/operations/auth_service.dart';
import 'package:class_critique_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore database;

  const SignupScreen({super.key, required this.auth, required this.database}); 

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // TextEditingController to extract text from Text fields of firstname, lastname, email and password
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController universityNameController = TextEditingController();

  late String _exception = '';

  @override
  Widget build(BuildContext context) {
    // Specify the width and height of the mobile app dynamically
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    void _createAccount() async {
      String email = emailController.text;
      String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _exception = 'Both email and password are required!';
          return;
        });
      }

      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String fullName = '$firstName $lastName';

      String universityName = universityNameController.text;

      String message = await AuthService(
              auth: widget.auth, database: widget.database)
          .performSignup(email, password, fullName, universityName);

      if (message.toLowerCase().contains('exception') ||
          message.toLowerCase().contains('error')) {
        setState(() {
          _exception = message;
        });
        if (widget.auth.currentUser != null) {
          print('current user is empty');
          await widget.auth.signOut(); // logout
        }
      } else {
        // no error
        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(auth: widget.auth , database: widget.database,)));
        print('Signup Successful: $message');
      }
    }

    return Scaffold(
      body: Container(
        width: screenWidth,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              // Scroll view to prevent overflow
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png'),
                    SizedBox(height: 16),
                    // First Name Text Field
                    TextField(
                      controller: firstNameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the First Name',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Last Name Text Field
                    TextField(
                      controller: lastNameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the Last Name',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Email Text Field
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the email',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Password Text Field
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the Password',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    // University Name Text Field
                    TextField(
                      controller: universityNameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the University Name',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: Center(
                        child: Row(
                          children: [
                            // Sign Up Button
                            Expanded(
                              child: ElevatedButton(
                                key: const Key("signupButton"),
                                //onPressed: () => {},
                                onPressed: () => _createAccount(),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Already a User?',
                              style: TextStyle(color: Colors.black)),
                        ),
                        // Navigate to Signup page
                        TextButton(
                          onPressed: () {
                            if (mounted) {
                              context
                                  .go('/login'); // redirect it to Signup Screen
                            }
                          },
                          child: Text('Sign in',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _exception.isEmpty
                        ? const SizedBox.shrink()
                        : Text(
                            _exception,
                            style: const TextStyle(color: Colors.red),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
