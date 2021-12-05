import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/my_user.dart';

class DismissDemo extends StatelessWidget {
  //
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Dismiss Demo')),

      //
      body: StreamBuilder(
        //
        stream: users.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          //
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              MyUser user =
                  MyUser.fromDocumentSnapshot(snapshot.data.docs[index]);

              //
              return Dismissible(
                //
                key: Key(user.docId),

                //
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${user.name[0].toUpperCase()}'),
                  ),
                  title: Text('${user.name}'),
                  subtitle: Text('${user.email}'),
                ),

                //
                onDismissed: (DismissDirection direction) {
                  //
                  deleteData(user, context);
                },

                //
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
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

  Future<void> deleteData(MyUser user, BuildContext context) async {
    // delete logic
    await users.doc(user.docId).delete();

    // show snack bar to undo the deleted data
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //
        content: Text('${user.name} deleted'),

        //
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            //
            await users.doc(user.docId).set(user.toMap());
          },
        ),
      ),
    );
  }
}
