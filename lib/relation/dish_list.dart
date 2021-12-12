import 'package:fb_demo/relation/add_dish.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  //
  final CollectionReference dishes =
      FirebaseFirestore.instance.collection('dishes');
  final CollectionReference reastaurants =
      FirebaseFirestore.instance.collection('restaurants');
  User? user;
  String username = '';

  //
  @override
  void initState() {
    super.initState();
    getUser();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  void getUser() async {
    user = FirebaseAuth.instance.currentUser;

    //
    user!.reload();

    DocumentSnapshot restaurantDocument =
        await reastaurants.doc(user!.uid).get();

    username = restaurantDocument['name'];

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('$username'),
      ),

      //
      body: StreamBuilder(
        //
        stream: dishes.where('restaurant_ID', isEqualTo: user!.uid).snapshots(),

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
                title: Text('${snapshot.data.docs[index]['dish_name']}'),
                subtitle: Text('${snapshot.data.docs[index]['price']}'),
              );
            },
          );
        },
      ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  AddDish(restaurantID: user!.uid),
            ),
          );
        },
      ),
    );
  }
}
