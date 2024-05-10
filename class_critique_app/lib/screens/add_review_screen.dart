import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddReviewScreen extends StatefulWidget {
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  // Define variables to hold user input data
  String? selectedCourse = 'All Courses';
  int rating = 0;
  String review = '';

  // Function to set the rating based on the selected star
  void setRating(int star) {
    setState(() {
      rating = star;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Center(
                      child: Text(
                        'Add Your Review',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: selectedCourse,
                    onChanged: (String? newValue) {
                      print('New Value $newValue');
                      // setState(() {
                      //   dropdownValue1 = newValue!;
                      // });
                      setState(() {
                        selectedCourse = newValue;
                      });
                      //_changeCourse(newValue!);
                    },
                    // items: (professorData['subjectsTaught'] != null)
                    //     ? (professorData['subjectsTaught']! as List<dynamic>)
                    //         .map<DropdownMenuItem<String>>((dynamic value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value.toString(),
                    //           child: Text(value),
                    //         );
                    //       }).toList()
                    //     : [],
                    selectedItemBuilder: (BuildContext context) {
                      return ['All Courses', 'CSCI 311', 'CSCI 630']
                          .map<Widget>((String value) {
                        return Center(
                          child: Text(value, textAlign: TextAlign.center),
                        );
                      }).toList();
                    },
                    items: ['All Courses', 'CSCI 311', 'CSCI 630']
                        .map((course) => DropdownMenuItem(
                              value: course,
                              child: Center(
                                  child: Text(
                                course,
                                textAlign: TextAlign.center,
                              )),
                            ))
                        .toList(),
                    underline: null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.yellow,
                          size: 40,
                        ),
                        onPressed: () {
                          setRating(index + 1);
                        },
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    review = value;
                  });
                },
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Write a Review',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Save review logic here
                    print(
                        'Course: $selectedCourse, Rating: $rating, Review: $review');
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text('Save Review'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
