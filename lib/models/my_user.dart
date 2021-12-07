import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyUser {
  //
  late String docId;
  late String name;
  late String email;
  late String dob;
  late int weekOff;
  late String lastSeen;

  // not done here
  MyUser({
    required this.name,
    required this.email,
  });

  // done here
  MyUser.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.docId = snapshot.id;
    this.name = snapshot['name'];
    this.email = snapshot['email'];
    this.dob = snapshot['dob'].toString();
    this.lastSeen = snapshot['last_seen'].toString();
    this.weekOff = snapshot['week_off'];
  }

  // not done here
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['email'] = this.email;

    return map;
  }
}
