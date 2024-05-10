import 'package:class_critique_app/firebase_options.dart';
import 'package:class_critique_app/operations/db_operations.dart';
import 'package:class_critique_app/screens/professors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  // setUpAll(() async {
  //   // Initialize Firebase once before running any tests
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // });

  late DBOperations dbOperations;
  final firestore = FakeFirebaseFirestore();

  setUp(() {
    dbOperations = DBOperations(database: firestore);
  });


  test('ProfessorScreen renders correctly', () async {
    // Set up mock data
    final mockData = {
      'professorName': 'Brian Herring',
      'professorImage': 'https://example.com/professor.jpg',
      'overallRating': 4.2,
      'subjectsTaught': ['Math', 'Physics'], 
    };

    // Mock Firestore
    final professorDoc =
        firestore.collection('professors').doc('7L7NgTqIZQifi8w14OrF');
    professorDoc.set(mockData);

    Map<String, dynamic>?
      dataMap = await dbOperations.fetchProfessor('7L7NgTqIZQifi8w14OrF');
      print(dataMap);
      expect(dataMap?['professorName'], 'Brian Herring');
  });

  // testWidgets('ProfessorScreen displays ratings correctly',
  //     (WidgetTester tester) async {
  //   // Set up mock data
  //   final mockData = {
  //     'professorName': 'John Doe',
  //     'professorImage': 'https://example.com/professor.jpg',
  //     'overallRating': 4.2,
  //     'subjectsTaught': ['Math', 'Physics'],
  //   };

  //   // Mock Firestore
  //   final firestore = FakeFirebaseFirestore();
  //   final professorDoc =
  //       firestore.collection('professors').doc('7L7NgTqIZQifi8w14OrF');
  //   professorDoc.set(mockData);

  //   // Add mock ratings
  //   final ratingsCollection = professorDoc.collection('ratings');
  //   ratingsCollection.add({
  //     'subject': 'Math',
  //     'rating': 5,
  //     'feedback': 'Great professor!',
  //     'time': Timestamp.now(),
  //   });
  //   ratingsCollection.add({
  //     'subject': 'Physics',
  //     'rating': 3,
  //     'feedback': 'Could be better.',
  //     'time': Timestamp.now(),
  //   });

  //   // Build the widget
  //   await tester.pumpWidget(MaterialApp(home: ProfessorScreen()));

  //   // Wait for the ratings to load
  //   await tester.pumpAndSettle();

  //   // Verify that the ratings are displayed correctly
  //   expect(find.text('Math'), findsWidgets);
  //   expect(find.text('Great professor!'), findsOneWidget);
  //   expect(find.text('Physics'), findsWidgets);
  //   expect(find.text('Could be better.'), findsOneWidget);
  // });

  // Add more test cases as needed
}
