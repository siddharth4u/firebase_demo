import 'package:fb_demo/get_profile.dart';
import 'package:fb_demo/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowProfileWithStream extends StatelessWidget {
  //
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),

      //
      body: StreamBuilder(
        stream: profileCollection.orderBy('name').snapshots(),
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
              //
              User user = User.fromDocumentSnapshot(snapshot.data.docs[index]);

              //
              return ListTile(
                //
                isThreeLine: true,
                // show image
                leading: user.imagePath == ''
                    ? CircleAvatar(
                        radius: 26,
                        child: Icon(Icons.person),
                      )
                    : FutureBuilder(
                        future: getImageURL(user.imagePath),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          //
                          if (!snapshot.hasData) {
                            return Container();
                          }

                          //
                          return CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(snapshot.data),
                          );
                        },
                      ),

                //
                title: Text('${user.name}'),

                //
                subtitle: Text('${user.email}'),
              );
            },
          );
        },
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => GetProfile(),
            ),
          );
        },
      ),
    );
  }

  //
  Future<String> getImageURL(String imagePath) async {
    Reference storageReference = firebaseStorage.ref(imagePath);
    String imageURL = await storageReference.getDownloadURL();
    return imageURL;
  }
}
