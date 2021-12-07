import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grouped_list/grouped_list.dart';

class SectionDemo extends StatelessWidget {
  //
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('name');

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Sectioned List')),

      //
      body: StreamBuilder(
        //
        stream: query.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //
          return GroupedListView<dynamic, String>(
            //
            elements: snapshot.data.docs,

            //
            groupBy: (singleElement) => singleElement['name'][0],

            //
            groupHeaderBuilder: (dynamic groupTitle) {
              return Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey.shade300,
                child: Text('${groupTitle['name'][0]}'),
              );
            },

            //
            itemBuilder: (BuildContext context, dynamic singleElement) {
              MyUser user = MyUser.fromDocumentSnapshot(singleElement);

              return ListTile(
                title: Text('${user.name}'),
                subtitle: Text('${user.email}'),
              );
            },
          );
        },
      ),
    );
  }
}
