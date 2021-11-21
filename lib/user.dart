import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late String id;
  late String name;
  late String email;
  late String imagePath;
  late String imageURL;

  //
  User({required this.name, required this.email, required this.imagePath});

  //
  User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    this.name = snapshot['name'];
    this.email = snapshot['email'];
    this.imagePath = snapshot['image_path'];
    this.id = snapshot.id;
  }

  //
  User.fromAnotherUser(User user) {
    this.name = user.name;
    this.email = user.email;
    this.id = user.id;
    this.imagePath = user.imagePath;
    this.imageURL = user.imageURL;
  }

  //
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['email'] = this.email;
    map['image_path'] = this.imagePath;

    return map;
  }
}
