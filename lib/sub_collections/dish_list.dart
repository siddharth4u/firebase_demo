import 'package:fb_demo/add_data.dart';
import 'package:fb_demo/sub_collections/add_dish.dart';
import 'package:fb_demo/sub_collections/edit_dish.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DishList extends StatefulWidget {
  @override
  _DishListState createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  //
  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? user;
  String username = '';
  Query? query;

  //
  @override
  void initState() {
    super.initState();

    //
    getUser();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUser() async {
    user = firebaseAuth.currentUser;

    await user!.reload();

    DocumentSnapshot restaurantDocument =
        await restaurants.doc(user!.uid).get();

    username = restaurantDocument['name'];

    // acees sub-collection
    query = restaurants.doc(user!.uid).collection('dishes');

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
      body: query == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: query!.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No Dishes to show'),
                  );
                }

                //
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('${snapshot.data.docs[index]['dish_name']}'),
                      subtitle: Text('${snapshot.data.docs[index]['price']}'),

                      //
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //
                          restaurants
                              .doc(user!.uid)
                              .collection('dishes')
                              .doc(snapshot.data.docs[index].id)
                              .delete();
                        },
                      ),

                      //
                      onTap: () {
                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => EditDish(
                              restaurantID: user!.uid,
                              dishID: snapshot.data.docs[index].id,
                              oldDishName: snapshot.data.docs[index]
                                  ['dish_name'],
                              oldDishPrice: snapshot.data.docs[index]['price'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddDish(
                documentID: user!.uid,
              ),
            ),
          );
        },
      ),
    );
  }
}
