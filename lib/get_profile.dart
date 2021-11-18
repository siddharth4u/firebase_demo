import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GetProfile extends StatefulWidget {
  @override
  _GetProfileState createState() => _GetProfileState();
}

class _GetProfileState extends State<GetProfile> {
  //
  File? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get User Profile'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // image
          Center(
            child: Container(
              child: Stack(
                children: [
                  //

                  image == null
                      ? CircleAvatar(
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 40,
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(image!),
                        ),

                  //
                  Positioned(
                    right: -10,
                    top: -10,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        getIamge();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // name
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Name'),
          ),

          SizedBox(height: 32),

          // email
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Email Id'),
          ),

          SizedBox(height: 32),

          // save button
          ElevatedButton(
            child: Text('Save Data'),
            onPressed: () {
              saveUserData();
            },
          ),
        ],
      ),
    );
  }

  //
  Future<void> getIamge() async {
    var capturedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (capturedImage != null) {
      setState(() {
        image = File(capturedImage.path);
      });
    }
  }

  //
  Future<void> saveUserData() async {
    String imageName = '';

    // uplad image
    if (image != null) {
      String fileExtension = image!.path.split('.').last;
      imageName = DateTime.now().microsecondsSinceEpoch.toString() +
          '.' +
          fileExtension;

      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      Reference firebaseReference =
          firebaseStorage.ref('profilePicture/$imageName');

      firebaseReference.putFile(image!);
    }

    // store data to firestore collection
    CollectionReference profile =
        FirebaseFirestore.instance.collection('profiles');
    await profile.add({
      'name': nameController.text,
      'email': emailController.text,
      'image_path': imageName == '' ? '' : 'profilePicture/$imageName',
    });
  }
}
