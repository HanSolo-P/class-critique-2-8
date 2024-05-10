import 'package:class_critique_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore database;

  const HomeScreen({super.key, required this.auth, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Home Page'),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                key: const Key("logoutButton"),
                onPressed: () async {
                  await widget.auth.signOut();


                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(auth: widget.auth, database: widget.database,)));
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
