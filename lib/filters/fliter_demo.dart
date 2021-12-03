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

  final List<String> productList = [];

  // variable for checkbox state management
  bool appleState = false;
  bool redmiState = false;
  bool vivoState = false;
  bool samsungState = false;
  bool oppoState = false;

  // variable to be added inside the productList
  String appleValue = '';
  String redmiValue = '';
  String vivoValue = '';
  String samsungValue = '';
  String oppoValue = '';

  //
  @override
  void initState() {
    super.initState();

    mangeProductList();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  //
  void mangeProductList() {
    productList.clear();

    productList.add(appleValue);
    productList.add(redmiValue);
    productList.add(samsungValue);
    productList.add(vivoValue);
    productList.add(oppoValue);
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    Query query = products.where('company', whereIn: productList);

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

          return Column(
            children: [
              //
              Container(
                height: 100,
                //color: Colors.red,
                child: Column(
                  children: [
                    // line 1
                    Row(
                      children: [
                        // apple
                        Row(
                          children: [
                            //
                            Checkbox(
                              value: appleState,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  appleState = newValue!;

                                  if (appleState) {
                                    appleValue = 'Apple';
                                  } else {
                                    appleValue = '';
                                  }

                                  mangeProductList();
                                });
                              },
                            ),

                            //
                            Text('Apple'),
                          ],
                        ),

                        // Redmi
                        Row(
                          children: [
                            //
                            Checkbox(
                              value: redmiState,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  redmiState = newValue!;

                                  if (redmiState) {
                                    redmiValue = 'Redmi';
                                  } else {
                                    redmiValue = '';
                                  }

                                  mangeProductList();
                                });
                              },
                            ),

                            //
                            Text('Redmi'),
                          ],
                        ),

                        // Oppo
                        Row(
                          children: [
                            //
                            Checkbox(
                              value: oppoState,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  oppoState = newValue!;

                                  if (oppoState) {
                                    oppoValue = 'Oppo';
                                  } else {
                                    oppoValue = '';
                                  }

                                  mangeProductList();
                                });
                              },
                            ),

                            //
                            Text('Oppo'),
                          ],
                        ),
                      ],
                    ),

                    // line 2
                    Row(
                      children: [
                        // apple
                        Row(
                          children: [
                            //
                            Checkbox(
                              value: samsungState,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  samsungState = newValue!;

                                  if (samsungState) {
                                    samsungValue = 'Samsung';
                                  } else {
                                    samsungValue = '';
                                  }

                                  mangeProductList();
                                });
                              },
                            ),

                            //
                            Text('Samsung'),
                          ],
                        ),

                        // Redmi
                        Row(
                          children: [
                            //
                            Checkbox(
                              value: vivoState,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  vivoState = newValue!;

                                  if (vivoState) {
                                    vivoValue = 'Vivo';
                                  } else {
                                    vivoValue = '';
                                  }

                                  mangeProductList();
                                });
                              },
                            ),

                            //
                            Text('Vivo'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //
              Expanded(
                child: ListView.builder(
                  //
                  itemCount: snapshot.data.docs.length,

                  //
                  itemBuilder: (BuildContext context, int index) {
                    //
                    Product product =
                        Product.fromSnapshot(snapshot.data.docs[index]);

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
                            Text(
                              '${product.ram}GB RAM',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text('${product.storage}GB Storage'),
                            Text('${product.discount}% discount'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
