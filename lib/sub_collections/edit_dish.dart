import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDish extends StatelessWidget {
  //
  final String restaurantID;
  final String dishID;
  final String oldDishName;
  final int oldDishPrice;

  final TextEditingController dishNameController = TextEditingController();
  final TextEditingController dishPriceController = TextEditingController();

  //
  EditDish({
    required this.restaurantID,
    required this.dishID,
    required this.oldDishName,
    required this.oldDishPrice,
  });

  //
  @override
  Widget build(BuildContext context) {
    //
    dishNameController.text = oldDishName;
    dishPriceController.text = oldDishPrice.toString();

    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Edit Dish'),
      ),

      //
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //
          TextField(
            controller: dishNameController,
            decoration: InputDecoration(
              hintText: 'Dish Name',
            ),
          ),

          SizedBox(height: 16),

          //
          TextField(
            controller: dishPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Dish Price',
            ),
          ),

          SizedBox(height: 16),

          //
          ElevatedButton(
            child: Text('Edit Dish'),
            onPressed: () async {
              await editDish();

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editDish() async {
    //
    String newDishName = dishNameController.text;
    int newDishPrice = int.parse(dishPriceController.text);

    await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantID)
        .collection('dishes')
        .doc(dishID)
        .update({'dish_name': newDishName, 'price': newDishPrice});
  }
}
