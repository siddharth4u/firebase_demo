import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grouped_list/grouped_list.dart';

//
class MonthDemo extends StatelessWidget {
  //
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('dob');
  //
  final List<String> monthsNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Month Demo'),
      ),

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
          return GroupedListView<dynamic, int>(
            //
            elements: snapshot.data.docs,

            //
            groupBy: (dynamic singleElement) {
              DateTime date = singleElement['dob'].toDate();
              int month = date.month;

              return month;
            },

            //
            groupHeaderBuilder: (dynamic singleElement) {
              DateTime date = singleElement['dob'].toDate();
              int month = date.month;

              return Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey.shade300,
                child: Text('${monthsNames[month - 1]}'),
              );
            },

            //
            itemBuilder: (BuildContext context, dynamic singleElement) {
              //
              MyUser user = MyUser.fromDocumentSnapshot(singleElement);

              //
              DateTime date = singleElement['dob'].toDate();
              int day = date.day;
              int month = date.month;
              int year = date.year;

              String formattedDate = '$day-${monthsNames[month - 1]}-$year';

              return ListTile(
                title: Text('${user.name}'),
                subtitle: Text('$formattedDate'),
              );
            },

            //
            itemComparator: (firstElement, secondElement) {
              int firstDateMilliSeconds =
                  firstElement['dob'].toDate().millisecondsSinceEpoch;
              int secondDateMilliSeconds =
                  secondElement['dob'].toDate().millisecondsSinceEpoch;

              return (firstDateMilliSeconds - secondDateMilliSeconds);
            },
          );
        },
      ),
    );
  }
}
