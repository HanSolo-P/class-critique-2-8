import 'package:cloud_firestore/cloud_firestore.dart';

class DBOperations {
  static Future<Map<String, dynamic>?> fetchProfessor(String professorId) async {
    try {
      // Get the collection reference for the provided professorId
      CollectionReference<Map<String, dynamic>> professorCollectionRef =
          FirebaseFirestore.instance.collection("professors");

      // Retrieve the document snapshot
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await professorCollectionRef.doc(professorId).get();

      // Check if the document exists
      if (snapshot.exists) {
        // Access document data
        Map<String, dynamic>? data = snapshot.data();
        CollectionReference<Map<String, dynamic>> ratingsCollectionRef =
            snapshot.reference.collection("ratings");

        //await fetchRatings(ratingsCollectionRef);
        await Future.delayed(Duration(seconds: 3));

        print('Data: $data');
        return data;
      } else {
        print('Document does not exist');
        throw 'Document does not exist';
      }
    } catch (e) {
      // Handle any errors that occur during Firestore operations
      print('Error fetching professor: $e');
      throw 'Error fetching professor: $e';
    }
  }

  static Future<void> fetchRatings(
      CollectionReference<Map<String, dynamic>> ratingsRef) async {
    print('Inside fetchRatings()');
    try {
      // Get the collection reference for the provided professorId
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await ratingsRef.get();

      print('fetchRatings querySnapshot - ${querySnapshot}');

      // Check if querySnapshot is valid
      if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
        // Iterate over the documents and print their data
        querySnapshot.docs.forEach((doc) {
          print('Document ID: ${doc.id}');
          print('Data: ${doc.data()}');
        });
      } else {
        print('No documents found in the collection.');
      }
    } catch (error, stackTrace) {
      print('Error fetching ratings: $error');
      // You can choose to throw the error or handle it here
      throw error;
    }
  }
}

void main() {
  String professorId = '7L7NgTqIZQifi8w14OrF';
  DBOperations.fetchProfessor(professorId);
}
