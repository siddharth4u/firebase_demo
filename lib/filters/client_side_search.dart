import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientSideSearch extends StatefulWidget {
  @override
  _ClientSideSearchState createState() => _ClientSideSearchState();
}

class _ClientSideSearchState extends State<ClientSideSearch> {
  //
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  String serchKey = '';
  List<MyUser> userList = [];

  @override
  void initState() {
    super.initState();

    //
    getUserData();
  }

  void getUserData() async {
    QuerySnapshot rawData = await users.get();
    List<DocumentSnapshot> documnetList = rawData.docs;

    //
    documnetList.forEach((singleDocumnt) {
      userList.add(MyUser.fromDocumentSnapshot(singleDocumnt));
    });

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Client Side Search'),
      ),

      //
      body: Column(
        children: [
          // show textfield
          Container(
            padding: EdgeInsets.all(16),
            height: 100,
            //color: Colors.red,
            child: TextField(
              //
              decoration: InputDecoration(hintText: 'Name'),

              //
              onChanged: (String newValue) {
                setState(() {
                  serchKey = newValue;
                });
              },
            ),
          ),

          Expanded(
            child:
                // show list of users
                serchKey == ''
                    ? Container()
                    : ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (BuildContext context, int index) {
                          //
                          String? name = userList[index].name;

                          return name!
                                  .toLowerCase()
                                  .contains(serchKey.toLowerCase())
                              ? ListTile(
                                  //
                                  title: Text('${userList[index].name}'),

                                  //
                                  subtitle: Text('${userList[index].email}'),
                                )
                              : Container();
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// User Model class
class MyUser {
  String? name;
  String? email;

  MyUser.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.name = snapshot['name'];
    this.email = snapshot['email'];
  }
}
