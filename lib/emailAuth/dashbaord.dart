import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_in.dart';

class Dashbaord extends StatefulWidget {
  @override
  _DashbaordState createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  //
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  String profession = '';
  String salary = '';

  //
  @override
  void initState() {
    super.initState();

    user = firebaseAuth.currentUser;
    user!.reload();

    getUserData();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  Future<void> getUserData() async {
    DocumentSnapshot documentSnapshot = await users.doc(user!.uid).get();

    profession = documentSnapshot['profession'];
    salary = documentSnapshot['salary'];

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user!.displayName}'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await firebaseAuth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignIn(),
                ),
              );
            },
          )
        ],
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          ListTile(
            title: Text('${user!.displayName}'),
            subtitle: Text('${user!.email}'),
          ),

          profession == ''
              ? Container()
              : ListTile(
                  title: Text('$profession'),
                  subtitle: Text('$salary'),
                ),
        ],
      ),
    );
  }
}
