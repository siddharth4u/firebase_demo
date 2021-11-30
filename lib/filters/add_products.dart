import 'package:fb_demo/filters/product.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //
              addProducts();
            },
          ),
        ],
      ),
    );
  }

  Future<void> addProducts() async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    var list = Product.productList;

    for (int i = 0; i < list.length; i++) {
      //
      products.add(list[i].toMap());
    }
  }
}
