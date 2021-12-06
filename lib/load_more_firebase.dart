import 'package:fb_demo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadMoreFirebase extends StatefulWidget {
  @override
  _LoadMoreFirebaseState createState() => _LoadMoreFirebaseState();
}

class _LoadMoreFirebaseState extends State<LoadMoreFirebase> {
  //
  final ScrollController scrollController = ScrollController();
  final Query query =
      FirebaseFirestore.instance.collection('users').orderBy('name');
  late DocumentSnapshot lastDocument;
  List<MyUser> userList = [];
  bool isLoading = false;

  //
  @override
  void initState() {
    super.initState();

    //
    loadInitialData();

    //
    scrollController.addListener(() {
      // make sure user has scrolled at end
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('You are edn');
        loadMoreData();
      }
    });
  }

  //
  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  //
  Future<void> loadInitialData() async {
    QuerySnapshot rawData = await query.limit(10).get();
    List<DocumentSnapshot> documentList = rawData.docs;

    documentList.forEach((DocumentSnapshot singleDocument) {
      userList.add(MyUser.fromDocumentSnapshot(singleDocument));
    });

    // save the last document
    lastDocument = documentList[documentList.length - 1];

    setState(() {
      //
    });
  }

  //
  Future<void> loadMoreData() async {
    //
    setState(() {
      isLoading = true;
    });

    QuerySnapshot rawData =
        await query.startAfter([lastDocument['name']]).limit(10).get();

    List<DocumentSnapshot> documentList = rawData.docs;

    // make sure that documents are fetched form firebase
    if (documentList.length > 0) {
      //
      documentList.forEach((DocumentSnapshot singleDocument) {
        userList.add(MyUser.fromDocumentSnapshot(singleDocument));
      });

      lastDocument = documentList[documentList.length - 1];
    }

    setState(() {
      isLoading = false;
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Load More Firebase')),

      //
      body: userList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                //
                ListView.builder(
                  //
                  controller: scrollController,

                  //
                  itemCount: userList.length,

                  //
                  itemBuilder: (BuildContext context, int index) {
                    // grab single user for the list of users
                    MyUser user = userList[index];

                    return ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text('${user.name}'),
                      subtitle: Text('${user.email}'),
                    );
                  },
                ),

                //
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
