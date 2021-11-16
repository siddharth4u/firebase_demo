import 'package:fb_demo/add_data.dart';
import 'package:fb_demo/edit_student.dart';
import 'package:fb_demo/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadStream extends StatelessWidget {
  //
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Data'),
      ),

      //
      body: StreamBuilder(
        // 1
        stream: studentsCollection.snapshots(),

        // 2
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Student student =
                  Student.fromDocumentSnapshot(snapshot.data.docs[index]);

              return ListTile(
                isThreeLine: true,

                // image
                leading: CircleAvatar(
                  radius: 24,
                  child: Text('${student.name[0]}'),
                ),

                // name
                title: Text('${student.name}'),

                // age & percentage
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Text('${student.age}'),

                    //
                    Text('${student.percentage}'),
                  ],
                ),

                //
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    //
                    await studentsCollection.doc(student.id).delete();
                  },
                ),

                //
                onTap: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          EditStudent(oldStudent: student),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddData(),
            ),
          );
        },
      ),
    );
  }
}
