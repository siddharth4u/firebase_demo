import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grouped_list/grouped_list.dart';

class SectionDemo extends StatelessWidget {
  //
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('name');
  final List<String> sections = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  //
  @override
  Widget build(BuildContext context) {
    print('build called');

    String letter = sections[0];
    bool createSection = true;
    return Scaffold(
      //
      appBar: AppBar(title: Text('Section Demo')),

      //
      body: StreamBuilder(
        //
        stream: query.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //
          return GroupedListView<dynamic, String>(
            elements: snapshot.data.docs,
            groupBy: (element) => element['name'][0],
            groupHeaderBuilder: (elel) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Text('Group based on ${elel['name'][0]}'),
              );
            },
            
            itemBuilder: (
              c,
              element,
            ) {
              //
              return ListTile(
                //
                title: Text('${element['name']}'),
                subtitle: Text('${element['email']}'),

                //
              );
            },
          );
        },
      ),
    );
  }
}
