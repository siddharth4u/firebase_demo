import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  //
  File? image;
  UploadTask? uploadTask;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Image Upload'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              getImage();
            },
          ),

          // image upload button
          image == null
              ? Container()
              : IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    uploadImage();
                  },
                ),
        ],
      ),

      //
      body: image == null
          ? Center(
              child: Text('No Image'),
            )
          : ListView(
              children: [
                // show image here
                Image.file(image!),

                SizedBox(height: 16),

                // show percentage of image uploaded here
                uploadTask == null
                    ? Container()
                    : ShowPercentage(uploadTask: uploadTask!),
              ],
            ),
    );
  }

  //
  Future<void> getImage() async {
    var capturedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (capturedImage != null) {
      setState(() {
        image = File(capturedImage.path);
      });
    }
  }

  Future<void> uploadImage() async {
    // get image extension
    String imageExtension = image!.path.split('.').last;

    // create unique file name
    String imageName =
        DateTime.now().microsecondsSinceEpoch.toString() + '.' + imageExtension;

    // get firebase storage
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // create image reference in advanced
    Reference firebaseReferece = firebaseStorage.ref('images/$imageName');

    // upload image to firebase storage
    uploadTask = firebaseReferece.putFile(image!);

    setState(() {
      //
    });
  }
}

class ShowPercentage extends StatelessWidget {
  //
  final UploadTask uploadTask;

  ShowPercentage({required this.uploadTask});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: uploadTask.snapshotEvents,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        //
        TaskSnapshot taskStatus = snapshot.data;
        int totalBytes = taskStatus.totalBytes;
        int byteTrasfered = taskStatus.bytesTransferred;

        String percentage =
            ((byteTrasfered / totalBytes) * 100).toStringAsFixed(0);

        return Center(
          child: Text(
            '$percentage %',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
