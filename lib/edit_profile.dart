import 'package:fb_demo/get_profile.dart';
import 'package:fb_demo/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final User user;

  EditProfile({required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  File? image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  late User oldUser;
  bool deleteProfilePicture = false;
  bool uploadNewProfilePicture = false;

  //
  @override
  void initState() {
    super.initState();
    oldUser = User.fromAnotherUser(widget.user);

    //
    nameController.text = oldUser.name;
    emailController.text = oldUser.email;
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${oldUser.name}'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // image
          Center(
            child: Container(
              // width: 100,
              // height: 100,
              child: Stack(
                children: [
                  // image
                  image == null
                      ? oldUser.imageURL == ''
                          ? CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(oldUser.imageURL),
                            )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(image!),
                        ),

                  // capture image button
                  Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        captureImage();
                      },
                    ),
                  ),

                  // delete image button
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: oldUser.imageURL == ''
                        ? Container()
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                            ),
                            onPressed: () {
                              deleteImage();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 32),

          // name
          TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),

          SizedBox(height: 32),

          // email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email Id',
            ),
          ),

          SizedBox(height: 16),

          // edit button
          ElevatedButton(
            child: Text('Edit Profile'),
            onPressed: () async {
              await editProfile();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  //
  Future<void> captureImage() async {
    var capturedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (capturedImage != null) {
      setState(() {
        image = File(capturedImage.path);
        uploadNewProfilePicture = true;
      });
    }
  }

  Future<void> editProfile() async {
    // delete image if user request for it
    if (deleteProfilePicture) {
      Reference storageReference = firebaseStorage.ref(oldUser.imagePath);
      await storageReference.delete();
      oldUser.imagePath = '';
    }

    String fileName = '';

    // upload new image if user has changed the image
    if (uploadNewProfilePicture) {
      String fileExtension = image!.path.split('.').last;
      fileName = DateTime.now().microsecondsSinceEpoch.toString() +
          '.' +
          fileExtension;

      Reference storageReference =
          firebaseStorage.ref('profilePicture/$fileName');
      UploadTask uploadTask = storageReference.putFile(image!);

      await uploadTask.whenComplete(() => null);
    }

    if (!uploadNewProfilePicture && oldUser.imagePath != '') {
      fileName = oldUser.imagePath;
    }

    // update profile data in firestore collection
    User newuser = User(
      name: nameController.text,
      email: emailController.text,
      imagePath: fileName == '' ? '' : 'profilePicture/$fileName',
    );

    await profileCollection.doc(oldUser.id).update(newuser.toMap());
  }

  Future<void> deleteImage() async {
    setState(() {
      oldUser.imageURL = '';
      deleteProfilePicture = true;
    });
  }
}
