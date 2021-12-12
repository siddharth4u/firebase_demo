import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DishList extends StatelessWidget {
  //
  final CollectionReference dishes =
      FirebaseFirestore.instance.collection('dishes');

  final String restaurantID;

  //
  DishList({required this.restaurantID});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Dish List'),
      ),

      //

      body: StreamBuilder(
        //
        stream:
            dishes.where('restaurant_ID', isEqualTo: restaurantID).snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //
          return ListView.builder(
            //
            itemCount: snapshot.data.docs.length,

            //
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('${snapshot.data.docs[index]['dish_name']}'),
                subtitle: Text('${snapshot.data.docs[index]['price']}'),
              );
            },
          );
        },
      ),
    );
  }
}
