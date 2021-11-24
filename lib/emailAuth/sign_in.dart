import 'package:fb_demo/emailAuth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dashbaord.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? user;
  String errorMessage = '';

  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          errorMessage == ''
              ? Container()
              : Container(
                alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  height: 100,
                  color: Colors.red.withOpacity(0.1),
                  child: Text(
                    '$errorMessage',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
          //
          SizedBox(height: 16),
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
          ElevatedButton(
            child: Text('Sign In'),
            onPressed: () {
              signInUser(context);
            },
          ),

          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Text('Don\'t have an account?'),

              //
              TextButton(
                child: Text('Sign Up'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SignUp(),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> signInUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //
      user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashbaord(),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Unable to Sign In. Please try again';
        });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message!;
      });
    }
  }
}
