import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchDemo extends StatefulWidget {
  @override
  _SearchDemoState createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  //

  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');

  String searchKey = '';

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();

    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Search Demo')),

      //
      body: Column(
        children: [
          // 1
          Container(
            padding: EdgeInsets.all(16),
            height: 80,
            child: TextField(
              decoration: InputDecoration(hintText: 'Person Name'),
              onChanged: (String namevalue) {
                setState(() {
                  searchKey = namevalue;
                });
              },
            ),
          ),

          // 2
          Expanded(
            child: searchKey == ''
                ? Center(
                    child: Text('No Data'),
                  )
                : StreamBuilder(
                    //
                    stream: profiles.orderBy('name').startAt([searchKey]).endAt(
                        [searchKey + '\uf8ff']).snapshots(),

                    //
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
                          return ListTile(
                            title: Text('${snapshot.data.docs[index]['name']}'),
                            subtitle:
                                Text('${snapshot.data.docs[index]['email']}'),
                          );
                        },
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
