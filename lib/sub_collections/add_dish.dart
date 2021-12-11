import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDish extends StatelessWidget {
  //
  final String documentID;
  final TextEditingController dishNameController = TextEditingController();
  final TextEditingController dishPriceController = TextEditingController();

  AddDish({required this.documentID});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Add New Dish'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          TextField(
            controller: dishNameController,
            decoration: InputDecoration(hintText: 'Dish Name'),
          ),

          SizedBox(height: 16),

          //
          TextField(
            controller: dishPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Dish Price'),
          ),

          SizedBox(height: 16),

          //
          ElevatedButton(
            child: Text('Add Dish'),
            onPressed: () async {
              await addNewDish();

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addNewDish() async {
    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(documentID)
        .collection('dishes')
        .add({
      'dish_name': dishNameController.text,
      'price': int.parse(dishPriceController.text),
    });
  }
}
