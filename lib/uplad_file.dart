import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class UploadFile extends StatefulWidget {
  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  //
  File? file;
  UploadTask? uploadTask;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //
        title: Text('Upload File'),

        //
        actions: [
          // capture file button
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {
              getFile();
            },
          ),

          // uplopad file button
          if (file != null)
            IconButton(
              icon: Icon(Icons.upload),
              onPressed: () {
                uploadFile();
              },
            ),
        ],
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          if (file != null) Text('${file!.path.split('/').last}'),

          SizedBox(height: 16),

          if (uploadTask != null) PercentageIndicator(uploadTask: uploadTask!),
        ],
      ),
    );
  }

  //
  Future<void> getFile() async {
    FilePickerResult? filePickerResult =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (filePickerResult != null) {
      setState(() {
        file = File(filePickerResult.files.first.path!);
        uploadTask = null;
      });
    }
  }

  //
  Future<void> uploadFile() async {
    // get file extension
    String fileExtension = file!.path.split('.').last;

    // create unique file name
    String fileName =
        DateTime.now().microsecondsSinceEpoch.toString() + '.' + fileExtension;

    // get firebase storeage
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // create reference for upload file
    Reference storageReference = firebaseStorage.ref('userContents/$fileName');

    // upload file at the reference to firestore
    uploadTask = storageReference.putFile(file!);

    //
    setState(() {
      //
    });
  }
}

class PercentageIndicator extends StatelessWidget {
  //
  final UploadTask uploadTask;

  //
  PercentageIndicator({required this.uploadTask});

  //
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: uploadTask.snapshotEvents,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        TaskSnapshot taskStatus = snapshot.data;

        int totalBytes = taskStatus.totalBytes;
        int byteTransfered = taskStatus.bytesTransferred;
        double percentage = (byteTransfered / totalBytes);
        String per = (percentage * 100).toStringAsFixed(0);

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //
              Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.green,
                  value: percentage,
                ),
              ),

              //
              Text('$per %'),
            ],
          ),
        );
      },
    );
  }
}
