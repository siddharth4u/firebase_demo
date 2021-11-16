import 'package:fb_demo/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddData extends StatelessWidget {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // name
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 24),

          // age
          TextField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Age',
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 24),

          // percentage
          TextField(
            controller: percentageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Percentage',
              labelText: 'Percentage',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 24),

          // add data button
          ElevatedButton(
            child: Text('Add Student'),
            onPressed: () async {
              await addStudent();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addStudent() async {
    //
    Student student = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      percentage: double.parse(percentageController.text),
    );

    //
    await studentsCollection.add(student.toMap());
  }
}
