import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_demo/emailAuth/dashbaord.dart';
import 'package:fb_demo/emailAuth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  User? user;
  String errorMessage = '';

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
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
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),

          SizedBox(height: 32),
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
          TextField(
            controller: professionController,
            decoration: InputDecoration(hintText: 'Profession'),
          ),

          SizedBox(height: 32),

          //
          TextField(
            controller: salaryController,
            decoration: InputDecoration(hintText: 'Salary'),
          ),

          SizedBox(height: 32),

          //
          ElevatedButton(
            child: Text('Sign Up'),
            onPressed: () {
              signUpUser(context);
            },
          ),

          //
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Text('Already have an account?'),

              //
              TextButton(
                child: Text('Sign In'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SignIn(),
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

  Future<void> signUpUser(BuildContext context) async {
    try {
      // create user with email & password

      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      user = userCredential.user;

      if (user != null) {
        //
        user!.updateDisplayName(nameController.text);

        await user!.reload();

        // store the required user data to firestore collection
        await users.doc(user!.uid).set({
          'profession': professionController.text,
          'salary': salaryController.text,
        });

        //

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Dashbaord(),
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Unable to create your account. Please try again';
        });
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        errorMessage = error.message!;
      });
    }
  }
}
