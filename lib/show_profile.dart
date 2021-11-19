import 'package:fb_demo/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  //
  CollectionReference profileReference =
      FirebaseFirestore.instance.collection('profiles');
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<User> userList = [];

  //
  @override
  void initState() {
    super.initState();

    getData();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getData() async {
    QuerySnapshot rawData = await profileReference.get();
    List<DocumentSnapshot> documentList = rawData.docs;

    for (int i = 0; i < documentList.length; i++) {
      userList.add(User.fromDocumentSnapshot(documentList[i]));
      userList[i].imageURL = await getImageURL(userList[i].imagePath);
    }

    setState(() {
      //
    });
  }

  Future<String> getImageURL(String imagePath) async {
    if (imagePath == '') {
      return Future.value('');
    }

    //
    Reference storageReference = firebaseStorage.ref(imagePath);

    String imageURL = await storageReference.getDownloadURL();

    return imageURL;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),

      //
      body: userList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  isThreeLine: true,

                  //
                  leading: userList[index].imageURL == ''
                      ? CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            size: 30,
                          ),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(userList[index].imageURL),
                        ),

                  //
                  title: Text('${userList[index].name}'),

                  //
                  subtitle: Text('${userList[index].email}'),
                );
              },
            ),
    );
  }

  //

}
