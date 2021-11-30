import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RefreshDemo extends StatefulWidget {
  @override
  _RefreshDemoState createState() => _RefreshDemoState();
}

class _RefreshDemoState extends State<RefreshDemo> {
  //
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');
  var prifileList = [];

  //
  @override
  void initState() {
    super.initState();

    //
    loadData();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  Future<void> loadData() async {
    //
    prifileList.clear();
    var rawData = await profiles.get();
    prifileList = rawData.docs;

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Refresh Demo')),

      //
      body: RefreshIndicator(
        //
        onRefresh: loadData,

        // backgroundColor: Colors.red,
        // color: Colors.white,
        // displacement: 10,

        //
        child: prifileList.length == 0
            ? Center(
                child: Text('No Data'),
              )
            : ListView.builder(
                //
                itemCount: prifileList.length,

                //
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    //
                    title: Text('${prifileList[index]['name']}'),

                    //
                    subtitle: Text('${prifileList[index]['email']}'),
                  );
                },
              ),
      ),
    );
  }
}
