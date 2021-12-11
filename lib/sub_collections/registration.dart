import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();

    //
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Restaurant Registration'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),

          SizedBox(height: 16),

          //
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),

          SizedBox(height: 16),

          //
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),

          SizedBox(height: 16),

          ElevatedButton(
            child: Text('Register'),
            onPressed: () {
              //
              registerUser();
            },
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> registerUser() async {
    //
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // create user
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        //
        await user.reload();

        //
        await restaurants.doc(user.uid).set({
          'name': name,
          'email': email,
        });
      } else {
        //
      }
    } on Exception catch (error) {
      print(error);
    }
  }
}
