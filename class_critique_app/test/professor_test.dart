import 'package:class_critique_app/operations/db_operations.dart';
import 'package:class_critique_app/screens/professors_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
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
    Map<String, dynamic>? dataMap =
        await dbOperations.fetchProfessor('7L7NgTqIZQifi8w14OrF');
    print(dataMap);
    expect(dataMap?['professorName'], 'Brian Herring');
  });

  testWidgets('ProfessorScreen widget', (WidgetTester tester) async {
    // Set up mock data
    final mockData = {
      'professorName': 'Brian Herring',
      'professorImage':
          'https://c8.alamy.com/comp/G39KNR/vector-illustration-of-cartoon-professor-G39KNR.jpg',
      'overallRating': 4.2,
      'subjectsTaught': ['CSCI 311', 'CSCI 630'],
    };

    // Mock Firestore
    final professorDoc =
        firestore.collection('professors').doc('7L7NgTqIZQifi8w14OrF');
    professorDoc.set(mockData);

    // Build the widget
    await tester.pumpWidget(MaterialApp(
        home: ProfessorScreen(
      database: firestore,
    )));

    // Wait for the FutureBuilder to complete
    await tester.pumpAndSettle();

    // Verify that the professor's name is displayed
    expect(find.text('Brian Herring'), findsOneWidget);

    //expect(find.byType(Image), findsOneWidget);

    // Verify that the overall rating is displayed
    expect(find.text('4.2'), findsOneWidget);

    // // Verify that the subjects taught dropdown has the correct options
    expect(find.text('All Courses'), findsOneWidget);
    expect(find.text('Sort by'), findsOneWidget);

    // Verify that the second dropdown is found
    final dropdown2Finder = find.byType(DropdownButton<String>).at(1);
    expect(dropdown2Finder, findsOneWidget);

  // Add more test cases as needed
});
}