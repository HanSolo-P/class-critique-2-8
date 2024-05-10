// ignore_for_file: prefer_const_constructors

import 'package:class_critique_app/operations/auth_service.dart';
import 'package:class_critique_app/screens/professors_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore database;

  const LoginScreen({super.key, required this.auth, required this.database});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController to extract text from Text fields of email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _exception = '';

  @override
  Widget build(BuildContext context) {
    // Specify the width and height of the mobile app dynamically
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    void _loginUser() async {
      String email = emailController.text;
      String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _exception = 'Both email and password are required!';
        });
      }

      String message = await AuthService(
              auth: widget.auth, database: widget.database)
          .performLogin(email, password);
      if (message.contains('Exception:')) {
        setState(() {
          _exception = message;
        });
      } else {
        print('Login User: $message');
        // no error
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfessorScreen(database: widget.database,)));
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
                    // Email Text Field
                    TextField(
                      key: const Key("emailField"),
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
                      key: const Key("passwordField"),
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
                    // Sign in Button
                    Container(
                      child: Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                key: const Key("loginButton"),
                                onPressed: () => _loginUser(),
                                child: Text(
                                  'Sign In',
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
                        // Navigate to Rest Password page
                        TextButton(
                          onPressed: () {},
                          child: Text('Forget password?',
                              style: TextStyle(color: Colors.black)),
                        ),
                        // Navigate to Signup page
                        TextButton(
                          onPressed: () {
                            if (mounted) {
                              context.go(
                                  '/signup'); // redirect it to Signup Screen
                            }
                          },
                          child: Text('Signup',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                    // Display Error if any
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
