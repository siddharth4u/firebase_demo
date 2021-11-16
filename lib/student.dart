import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  //
  late String id;
  late String name;
  late int age;
  late double percentage;
  

  //
  Student({
    required this.name,
    required this.age,
    required this.percentage,
  });

  //
  Student.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.id = documentSnapshot.id;
    this.name = documentSnapshot['name'];
    this.age = documentSnapshot['age'];
    this.percentage = documentSnapshot['percentage'];
  }

  //
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['age'] = this.age;
    map['percentage'] = this.percentage;

    return map;
  }
}
