import 'package:fb_demo/emailAuth/sign_in.dart';
import 'package:fb_demo/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'create_user.dart';
import 'emailAuth/dashbaord.dart';
import 'emailAuth/sign_in_with_email_validation.dart';
import 'get_profile.dart';

import 'image_upload.dart';
import 'my_sign_in.dart';
import 'phoneAuth/phone_authentication.dart';
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
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    //  home: isUserLogedIn() ? Dashbaord() : SignIn(),
    home: MySignIn(),
    );
  }

  bool isUserLogedIn() {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
