import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;

  //
  @override
  void initState() {
    super.initState();
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
        title: Text('Image Upload'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: () {
              //
              getImage();
            },
          )
        ],
      ),

      //
      body: image == null
          ? Center(
              child: Text('No Image'),
            )
          : Image.file(image!),
    );
  }

  Future<void> getImage() async {
    //
    var capturedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (capturedImage != null) {
      //
      image = File(capturedImage.path);

      setState(() {
        //
      });
    }
  }
}
