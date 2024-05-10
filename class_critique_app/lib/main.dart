import 'package:class_critique_app/firebase_options.dart';
import 'package:class_critique_app/screens/home_screen.dart';
import 'package:class_critique_app/screens/login_screen.dart';
import 'package:class_critique_app/screens/professors_screen.dart';
import 'package:class_critique_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginScreen();
          } else {
            final databases = FirebaseFirestore.instance;
            return ProfessorScreen(database: databases, ); //HomeScreen();
          }
        }),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
        path: '/home',
        builder: (context, state) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        }),
    GoRoute(
      path: '/professor',
      builder: (context, state) => ProfessorScreen(database: FirebaseFirestore.instance,),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerConfig: _router,
      //home: const MyHomePage(title: 'Class Critique'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Class-Critique Starter App',
            ),
          ],
        ),
      ),
    );
  }
}
