import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grouped_list/grouped_list.dart';

class MonthWiseSections extends StatelessWidget {
  //
  //
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('week_off');
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
  final List<String> dayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Month Wise Sections'),
      ),

      //
      body: StreamBuilder(
        //
        stream: query.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          //
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //
          return GroupedListView<dynamic, int>(
            //
            elements: snapshot.data.docs,

            //
            groupBy: (element) => element['week_off'],

            //
            groupHeaderBuilder: (element) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Text('${dayNames[element['week_off'] - 1]}'),
              );
            },

            //
            itemBuilder: (BuildContext context, dynamic singleElement) {
              //
              MyUser user = MyUser.fromDocumentSnapshot(singleElement);

              return Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                color: Colors.grey.shade300,
                margin: EdgeInsets.all(16),
                child:
                    //
                    ListTile(
                  title: Text('${user.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.email}'),
                      Text('Week off day : ${dayNames[user.weekOff - 1]}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
