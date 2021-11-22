import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  //
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // name
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          SizedBox(height: 32),

          // email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          SizedBox(height: 32),

          // password
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          SizedBox(height: 32),

          // register button
          ElevatedButton(
            child: Text('Register'),
            onPressed: () {
              registerUser();
            },
          ),
        ],
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      user!.updateDisplayName(nameController.text);
      

      if (user != null) {
        print('User registered');
      } else {
        print('Unable to register user');
      }
    } on FirebaseAuthException catch (error) {
      print('Got error : ${error.message}');
    }
  }
}
