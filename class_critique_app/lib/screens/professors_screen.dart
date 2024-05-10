// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:class_critique_app/operations/db_operations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfessorScreen extends StatefulWidget {
   final FirebaseFirestore _database;
  const ProfessorScreen({required FirebaseFirestore database, Key? key})
      : _database = database, super(key: key);


  @override
  State<ProfessorScreen> createState() => _ProfessorScreenState(_database);
}

class _ProfessorScreenState extends State<ProfessorScreen> {
  String professorId = '7L7NgTqIZQifi8w14OrF';
  bool isLoading = false;
  late Stream<QuerySnapshot> _ratingsStream;
  late Future<Map<String, dynamic>?>
  dataMap; // = DBOperations.fetchProfessor(professorId);

  late String dropdownValue1 = 'All Courses';
  String dropdownValue2 = 'Sort by';
  List<String> subjectTaught = [];

  final FirebaseFirestore _database;
  _ProfessorScreenState(FirebaseFirestore database):
      _database = database;


  @override
  void initState() {
    dataMap = DBOperations(database: _database).fetchProfessor(professorId);
    super.initState();

    _fetchData();
  }

  Future<void> _fetchData() async {
    _ratingsStream = _database
        .collection('professors')
        .doc(professorId)
        .collection("ratings")
        .snapshots();

    setState(() {
      isLoading = true; // Set loading state to true
    });
    try {
      dataMap = DBOperations(database: _database).fetchProfessor(professorId);
    } catch (error) {
      // Handle error, show error message, etc.
      print('Error fetching professor: $error');
    }
  }

  void _changeCourse(String newValue) {
    if (newValue.isEmpty) {
      return;
    }
    if (newValue == 'All Courses') {
      // Reset the ratings stream
      setState(() {
        dropdownValue1 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .snapshots();
      });
    } else {
      setState(() {
        dropdownValue1 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .where('subject', isEqualTo: newValue)
            .snapshots();
      });
    }
  }

  void _changeRatings(String newValue) {
    if (newValue.isEmpty) {
      return;
    }
    if (newValue == 'Sort by') {
      // Reset the ratings stream
      setState(() {
        dropdownValue2 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .snapshots();
      });
    } else if (newValue == 'Rating Low to High') {
      // Reset the ratings stream
      setState(() {
        dropdownValue2 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .orderBy('rating')
            .snapshots();
      });
    } else if (newValue == 'Rating High to Low') {
      // Reset the ratings stream
      setState(() {
        dropdownValue2 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .orderBy('rating', descending: true)
            .snapshots();
      });
    } else if (newValue == 'Earliest Date') {
      setState(() {
        dropdownValue2 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .orderBy('time')
            .snapshots();
      });
    } else if (newValue == 'Latest Date') {
      setState(() {
        dropdownValue2 = newValue;
        _ratingsStream = _database
            .collection('professors')
            .doc(professorId)
            .collection("ratings")
            .orderBy('time', descending: true)
            .snapshots();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          elevation: 4,
          backgroundColor: Colors.white,
          title: Text('Professor Details'),
        ),
      ),
      backgroundColor: Color(0xFFE8F5FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: FutureBuilder<Map<String, dynamic>?>(
            future: dataMap, // Use your future here
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data found');
              } else {
                // Professor details
                final professorData = snapshot.data!;
                List<dynamic> subjectsTaught =
                    snapshot.data!['subjectsTaught'] ?? [];

                // Add 'All Courses' as the first item in the list
                // Ensure dropdownValue1 is a valid item in the list
                if (!subjectsTaught.contains(dropdownValue1)) {
                  subjectsTaught.insert(0, 'All Courses');
                }

                return Column(
                  children: [
                    // Image at the top
                    ClipOval(
                      child: Image.network(
                        professorData['professorImage'],
                        width: 120, // Adjust the width as needed
                        height: 120, // Adjust the height as needed
                        fit: BoxFit.cover, // Adjust the BoxFit as needed
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      professorData['professorName'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Divider for separation

                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(
                            255, 191, 215, 232), // Set background color
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Set border radius
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          // Overall Rating with Star Icon
                          Text(
                            professorData['overallRating'].toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 28),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 28),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 28),
                                Icon(Icons.star,
                                    color: Colors.yellow, size: 28),
                                Icon(Icons.star, color: Colors.grey, size: 28),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // First Dropdown
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              value: dropdownValue1,
                              onChanged: (String? newValue) {
                                print('New Value $newValue');
                                // setState(() {
                                //   dropdownValue1 = newValue!;
                                // });
                                _changeCourse(newValue!);
                              },
                              items: (professorData['subjectsTaught'] != null)
                                  ? (professorData['subjectsTaught']!
                              as List<dynamic>)
                                  .map<DropdownMenuItem<String>>(
                                      (dynamic value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(value),
                                    );
                                  }).toList()
                                  : [],
                              underline: null,
                            ),
                          ),
                          // Second Dropdown
                          Container(
                            padding: EdgeInsets.only(left: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              value: dropdownValue2,
                              onChanged: (String? newValue) {
                                // setState(() {
                                //   dropdownValue2 = newValue!;
                                // });
                                _changeRatings(newValue!);
                              },
                              items: <String>[
                                'Sort by',
                                'Rating Low to High',
                                'Rating High to Low',
                                'Latest Date',
                                'Earliest Date'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _ratingsStream,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text('No Events found'));
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var document = snapshot.data!.docs[index];
                                    var rating =
                                    document.data() as Map<String, dynamic>;
                                    Timestamp timestamp = rating['time'];
                                    DateTime dateTime = timestamp.toDate();
                                    String formattedTime =
                                    DateFormat('MMM dd, yyyy, HH:mm')
                                        .format(dateTime);

                                    return Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Card(
                                        color: Color(0xFFCFEBFF),
                                        child: ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(rating['subject']),
                                                  Text(formattedTime),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.yellow),
                                                  Icon(Icons.star,
                                                      color: Colors.grey),
                                                  SizedBox(width: 5),
                                                  Text(
                                                      '(${rating['rating'].toString()})',
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          ),
                                          subtitle: Text(
                                            rating['feedback'],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          onTap: () {
                                            // Handle tap on the card
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Color(0xff0095FF),
          elevation: 20,
          onPressed: () {
            /*
            showModalBottomSheet(
                context: context,
                builder: (context) => // AddReviewScreen(
//                      app: widget.app,
                ));*/
          },
        ),
      ),
    );
  }
}


