import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServerSideSearch extends StatefulWidget {
  @override
  _ServerSideSearchState createState() => _ServerSideSearchState();
}

class _ServerSideSearchState extends State<ServerSideSearch> {
  //
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  String searchKey = '';

  //
  @override
  Widget build(BuildContext context) {
    //
    Query query = users.where(
          'name_search',
          arrayContains: searchKey,
          
        );

    //
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Server Side Search'),
      ),

      //
      body: Column(
        children: [
          //
          Container(
            padding: EdgeInsets.all(16),
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Name',
              ),

              //

              onChanged: (String newValue) {
                setState(() {
                  searchKey = newValue;
                });
              },
            ),
          ),

          //
          Expanded(
              child: searchKey == ''
                  ? Container()
                  : StreamBuilder(
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
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              ///
                              title:
                                  Text('${snapshot.data.docs[index]['name']}'),
                              //
                              subtitle:
                                  Text('${snapshot.data.docs[index]['email']}'),
                            );
                          },
                        );
                      },
                    )),
        ],
      ),
    );
  }
}
