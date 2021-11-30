import 'dart:developer';

import 'package:fb_demo/filters/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilterDemo extends StatefulWidget {
  @override
  _FilterDemoState createState() => _FilterDemoState();
}

class _FilterDemoState extends State<FilterDemo> {
  //
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    Query query = products.where('company', isEqualTo: 'Samsung');

    //
    return Scaffold(
      //
      appBar: AppBar(title: Text('Filter Demo')),

      //
      body: StreamBuilder(
        //
        stream: query.snapshots(),

        //
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            //
            itemCount: snapshot.data.docs.length,

            //
            itemBuilder: (BuildContext context, int index) {
              //
              Product product = Product.fromSnapshot(snapshot.data.docs[index]);

              return Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text('${product.name}'),
                      Text('from ${product.company}'),
                      Text('\u20b9 ${product.price}'),
                      Text('${product.ram}GB RAM'),
                      Text('${product.storage}GB Storage'),
                      Text('${product.discount}% discount'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
