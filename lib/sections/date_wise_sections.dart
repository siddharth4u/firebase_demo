import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grouped_list/grouped_list.dart';

class DateWiseSection extends StatelessWidget {
  //
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('last_seen');

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Date Wise Section'),
      ),

      //
      body: StreamBuilder(
        stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //
          return GroupedListView<dynamic, dynamic>(
            //
            elements: snapshot.data.docs,

            //
            groupBy: (singleElement) {
              Timestamp timestamp = singleElement['last_seen'];

              DateTime date = timestamp.toDate();

              return date.day.toString();
            },

            //
            groupHeaderBuilder: (singleElement) {
              //
              DateTime date = singleElement['last_seen'].toDate();
              String formattedDate = '${date.day}-${date.month}-${date.year}';

              //
              return Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(16),
                child: Text('$formattedDate'),
              );
            },

            //
            itemBuilder: (BuildContext context, dynamic singleElement) {
              DateTime date = singleElement['last_seen'].toDate();

              int hours = 0;
              int minutes = date.minute;
              String ampm = '';

              if (date.hour >= 12) {
                hours = date.hour - 12;
                ampm = 'PM';
              } else {
                hours = date.hour;
                ampm = 'AM';
              }
              String formattedTime = '$hours:$minutes:$ampm';

              //
              MyUser user = MyUser.fromDocumentSnapshot(singleElement);

              return ListTile(
                title: Text('${user.name}'),
                subtitle: Text('$formattedTime'),
              );
            },
          );
        },
      ),
    );
  }
}
