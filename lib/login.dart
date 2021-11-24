import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loginFailed = false;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          loginFailed
              ? Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.red.withOpacity(0.5),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Text('Invalid Email or Password'),

                      //
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            loginFailed = false;
                          });
                        },
                      ),
                    ],
                  ),
                )
              : Container(),

          SizedBox(height: 16),

          // email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              labelText: 'Email',
            ),
          ),

          SizedBox(height: 32),

          // Password
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
            ),
          ),

          SizedBox(height: 32),

          // login button
          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              //
              login();
            },
          )
        ],
      ),
    );
  }

  Future<void> login() async {
    try {
      //
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //
      User? user = userCredential.user;

      if (user == null) {
        print('Failed to login');
      } else {
        print('Login succsed');
      }
    } on FirebaseAuthException catch (error) {
      print('Login error : ${error.message}');

      setState(() {
        loginFailed = true;
      });
    }
  }
}
