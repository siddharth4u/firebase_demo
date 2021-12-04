import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUsers extends StatelessWidget {
  //
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Add Users')),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          TextField(
            controller: nameController,

            //
            decoration: InputDecoration(
              hintText: 'Name',
              labelText: 'Name',
            ),
          ),

          SizedBox(height: 32),

          //
          TextField(
            controller: emailController,

            //
            decoration: InputDecoration(
              hintText: 'Email Id',
              labelText: 'Email Id',
            ),
          ),

          SizedBox(height: 32),

          //
          ElevatedButton(
            child: Text('Add User'),
            onPressed: () {
              addUsers();
            },
          ),
        ],
      ),
    );
  }

  void addUsers() async {
    String name = nameController.text;
    String email = emailController.text;
    List<String> nameSearch = [];

    //
    for (int i = 0; i < name.length; i++) {
      nameSearch.add(name.substring(0, i + 1));
    }

    //
    await users.add({
      'name': name,
      'email': email,
      'name_search': nameSearch,
    });

    //
    nameController.clear();
    emailController.clear();
  }
}
