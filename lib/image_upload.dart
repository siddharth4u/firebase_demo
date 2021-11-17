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

  @override
  void initState() {
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),

        //
        actions: [
          //
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              //
              getImage();
            },
          ),

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
                //
                Image.file(
                  image!,
                ),

                SizedBox(height: 16),

                //
                image == null ? Text('%') : showPercentage(),
              ],
            ),
    );
  }

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
    // get File extension
    String fileExtension = image!.path.split('.').last;

    // create unique file name
    String uniqueFileName =
        DateTime.now().microsecondsSinceEpoch.toString() + '.' + fileExtension;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref('images/$uniqueFileName');
    uploadTask = reference.putFile(image!);

    setState(() {
      //
    });
    TaskSnapshot taskSnapshot = await uploadTask!.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    print(downloadURL);
  }

  Widget showPercentage() {
    return uploadTask == null
        ? Container()
        : StreamBuilder(
            stream: uploadTask!.snapshotEvents,
            builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              TaskSnapshot taskStatus = snapshot.data;

              int totalByte = taskStatus.totalBytes;
              int byteTrasfered = taskStatus.bytesTransferred;

              String percentage =
                  ((byteTrasfered / totalByte) * 100).toStringAsFixed(0);

              return Center(child: Text('$percentage %'));
            },
          );
  }
}
