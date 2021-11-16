import 'package:fb_demo/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadData extends StatefulWidget {
  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  //
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  List<Student> studentList = [];

  //
  void getStudentData() async {
    QuerySnapshot rawData = await studentsCollection.get();
    List<DocumentSnapshot> documentList = rawData.docs;

    for (int i = 0; i < documentList.length; i++) {
      studentList.add(Student.fromDocumentSnapshot(documentList[i]));
    }

    setState(() {
      //
    });
  }

  //
  @override
  void initState() {
    super.initState();
    getStudentData();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Read Data')),

      //
      body: studentList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  isThreeLine: true,
                  title: Text('${studentList[index].name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text('${studentList[index].age}'),

                      //
                      Text('${studentList[index].percentage}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
