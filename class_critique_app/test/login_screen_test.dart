import 'package:class_critique_app/screens/login_screen.dart';
import 'package:class_critique_app/screens/professors_screen.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const _email = 'classcritique@gmail.com';
  const _uid = '519f80f7-02d9-4858-b468-f4403bc069ad';
  const _fullName = 'classcritique';

  final _mockUser = MockUser(
    uid: _uid,
    email: _email,
    displayName: _fullName,
  );

  final _mockAuth = MockFirebaseAuth(signedIn: true, mockUser: _mockUser);
  final firestore = FakeFirebaseFirestore();

      final mockData = {
      'professorName': 'Brian Herring',
      'professorImage': 'https://example.com/professor.jpg',
      'overallRating': 4.2,
      'subjectsTaught': ['CSCI 311', 'CSCI 630'],
    };
    // Mock Firestore
    final professorDoc =
        firestore.collection('professors').doc('7L7NgTqIZQifi8w14OrF');
    professorDoc.set(mockData);

  group('Login Page Tests', () {
    testWidgets('Check level page widget and ui loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen(auth: _mockAuth, database: firestore,)));

      expect(find.text('Sign In'), findsOneWidget);

      //find the beginner button
      final loginButton = find.byKey(const ValueKey("loginButton"));

      //make sure button is found
      expect(loginButton, findsOneWidget);
      //press button
      await tester.tap(loginButton);

      //give time to settle on new page
      await tester.pumpAndSettle();

      //find the fitness page widget which confirms we are on fitness page
      expect(find.byType(ProfessorScreen), findsOneWidget);
      
    });
  });
}
