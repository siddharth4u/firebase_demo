import 'dart:async';

import 'package:fb_demo/emailAuth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashbaord.dart';

class SignInWithEmailValidation extends StatefulWidget {
  @override
  _SignInWithEmailValidationState createState() =>
      _SignInWithEmailValidationState();
}

class _SignInWithEmailValidationState extends State<SignInWithEmailValidation> {
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? user;
  Timer? timer;
  int remaingSeconds = 120;

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
      appBar: AppBar(title: Text('Sign Up')),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),

          SizedBox(height: 32),

          //
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),

          SizedBox(height: 32),

          //
          MaterialButton(
            height: 50,
            minWidth: double.infinity,
            color: Colors.blue,
            child: Text('Sign Up'),
            onPressed: () {
              //
              signUpUser();
            },
          ),

          SizedBox(height: 32),

          timer == null
              ? Container()
              : Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      //
                      Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: (remaingSeconds / 120),
                          color: Colors.green,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                        ),
                      ),

                      //
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            '${remaingSeconds ~/ 60}:${remaingSeconds % 60}'),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  //
  Future<void> signUpUser() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      user = userCredential.user;

      if (user != null) {
        //
        user!.sendEmailVerification();
        user!.reload();

        verifyUserEmail();
        //
      } else {
        //
      }
    } on FirebaseAuthException catch (error) {
      print(error);
    }
  }

  void verifyUserEmail() {
    //
    timer = Timer.periodic(Duration(seconds: 1), (currentTimer) {
      user = firebaseAuth.currentUser;
      user!.reload();

      setState(() {
        remaingSeconds = remaingSeconds - 1;
      });

      if (user!.emailVerified) {
        timer!.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashbaord(),
          ),
        );
      } else {
        if (remaingSeconds == 0) {
          timer!.cancel();
          // timer is over
          // user email in not verified
        }
      }
    });
  }
}
