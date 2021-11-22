import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_user.dart';
import 'get_profile.dart';
import 'image_upload.dart';
import 'read_data.dart';
import 'read_stream.dart';
import 'show_profile.dart';
import 'show_profile_with_stream.dart';
import 'uplad_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateUser(),
    );
  }
}
