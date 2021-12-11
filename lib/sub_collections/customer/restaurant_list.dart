import 'package:fb_demo/sub_collections/customer/dish_list.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('All Restaurants'),
      ),

      //
      body: StreamBuilder(
        //
        stream:
            FirebaseFirestore.instance.collection('restaurants').snapshots(),

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
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('${snapshot.data.docs[index]['name']}'),
                subtitle: Text('${snapshot.data.docs[index]['email']}'),

                //
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          DishList(restaurantID: snapshot.data.docs[index].id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
