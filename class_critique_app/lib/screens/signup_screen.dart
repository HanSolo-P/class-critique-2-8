// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  
  SignupScreen({super.key});

  //final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Future<void> _login(BuildContext context) async {
  //   _authService
  //       .login(email: emailController.text, password: passwordController.text)
  //       .then((message) {
  //     // Login successful
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => Home()),
  //     );
  //   }).catchError((error) {
  //     // Login failed
  //     showDialog(
  //         context: context,
  //         builder: (context) =>
  //             CustomDialog(title: 'Error', message: error.toString()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //         'assets/login_background.png'), // Replace with your actual background image
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Container(
          width: screenWidth,
          height: screenHeight,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(colors: [
          //     Colors.red[800]?.withOpacity(0.7) ?? Colors.red.withOpacity(0.7),
          //     Colors.black.withOpacity(0.5),
          //     Colors.blue[800]?.withOpacity(0.7) ?? Colors.blue.withOpacity(0.7)
          //   ]),
          // ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo.png'),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter the First Name',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter the Last Name',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Enter the email',
                        labelStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter the Password',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                              color: Colors.black), // Set border color to white
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => {},
                              // onPressed: () => _login(context),
                              child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                              style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
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
