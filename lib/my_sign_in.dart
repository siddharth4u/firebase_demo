import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MySignIn extends StatefulWidget {
  @override
  _MySignInState createState() => _MySignInState();
}

class _MySignInState extends State<MySignIn> {
  //

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      //
      body: Center(
        child: ElevatedButton(
          child: Text('Sign In with Google'),
          onPressed: () {
            //
            signInWithGoogle();
          },
        ),
      ),
    );
  }

  //
  Future<void> signInWithGoogle() async {
    try {
      // 1 Intiate Google Sigin in Object
      // its an entry point for google authetication
      GoogleSignIn googleSignIn = GoogleSignIn();

      // 2 request or open all google accounts in your device
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      // 3 create authentication object that needs to send for google server
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      // 4 send authentication object to google server in order to create credential object
      AuthCredential authCredential = await GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // 5 sign in with crendential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      // 6 create user form userCredential
      User? user = userCredential.user;

      await user!.reload();

      if (user != null) {
        print('User ${user.displayName} created');
      } else {
        print('Unable to create user with google');
      }
    } on Exception catch (error) {
      print(error);
    }
  }
}
