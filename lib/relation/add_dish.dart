import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDish extends StatelessWidget {
  //
  final String restaurantID;

  //
  final TextEditingController dishNameController = TextEditingController();
  final TextEditingController dishPriceController = TextEditingController();
  final CollectionReference dishes =
      FirebaseFirestore.instance.collection('dishes');

  //
  AddDish({required this.restaurantID});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Add Dish'),
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

          ElevatedButton(
            child: Text('Add Dish'),
            onPressed: () async {
              await addDish();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addDish() async {
    await dishes.add({
      'dish_name': dishNameController.text,
      'price': int.parse(dishPriceController.text),
      'restaurant_ID': restaurantID,
    });
  }
}
