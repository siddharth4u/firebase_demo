import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'geocoding/get_location.dart';


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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
    //  home: isUserLogedIn() ? Dashbaord() : SignIn(),
    home: GetLocation(),
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
