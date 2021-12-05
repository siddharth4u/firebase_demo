import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyUser {
  //
  late String docId;
  late String name;
  late String email;

  //
  MyUser({
    required this.name,
    required this.email,
  });

  //
  MyUser.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.docId = snapshot.id;
    this.name = snapshot['name'];
    this.email = snapshot['email'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['email'] = this.email;

    return map;
  }
}
