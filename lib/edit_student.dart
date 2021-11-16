import 'package:fb_demo/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditStudent extends StatelessWidget {
  //
  final Student oldStudent;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');
  EditStudent({required this.oldStudent});

  //
  @override
  Widget build(BuildContext context) {
    // intialize controller value
    nameController.text = oldStudent.name;
    ageController.text = oldStudent.age.toString();
    percentageController.text = oldStudent.percentage.toString();

    //
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),

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

          SizedBox(height: 32),

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

          SizedBox(height: 32),

          // age
          TextField(
            controller: percentageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Percentage',
              labelText: 'Percentage',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 32),

          //
          ElevatedButton(
            child: Text('Edit Student'),
            onPressed: () async {
              //
              await editStudent();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editStudent() async {
    //
    Student newStudent = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      percentage: double.parse(percentageController.text),
    );

    //
    await studentsCollection.doc(oldStudent.id).update(newStudent.toMap());
  }
}
