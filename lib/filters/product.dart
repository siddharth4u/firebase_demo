import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  //
  late String name;
  late int price;
  late String company;
  late int ram;
  late int storage;
  late int discount;

  //
  Product({
    required this.name,
    required this.price,
    required this.company,
    required this.ram,
    required this.storage,
    required this.discount,
  });

  //
  Product.fromSnapshot(DocumentSnapshot snapshot) {
    this.name = snapshot['name'];
    this.price = snapshot['price'];
    this.company = snapshot['company'];
    this.ram = snapshot['ram'];
    this.storage = snapshot['storage'];
    this.discount = snapshot['discount'];
  }

  //
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    //
    map['name'] = this.name;
    map['price'] = this.price;
    map['company'] = this.company;
    map['ram'] = this.ram;
    map['storage'] = this.storage;
    map['discount'] = this.discount;

    //
    return map;
  }

  //

  static List<Product> productList = [
    //
    Product(
      name: 'Redmi 9I',
      price: 12000,
      company: 'Redmi',
      ram: 4,
      storage: 64,
      discount: 10,
    ),

    //
    Product(
      name: 'Samsung Galaxy M21',
      price: 15500,
      company: 'Samsung',
      ram: 4,
      storage: 64,
      discount: 5,
    ),

    //
    Product(
      name: 'Oppo A31',
      price: 12300,
      company: 'Oppo',
      ram: 3,
      storage: 32,
      discount: 15,
    ),

    //
    Product(
      name: 'Oppo F11',
      price: 18500,
      company: 'Oppo',
      ram: 4,
      storage: 64,
      discount: 0,
    ),

    //
    Product(
      name: 'Samsung M32',
      price: 25300,
      company: 'Samsung',
      ram: 6,
      storage: 128,
      discount: 5,
    ),

    //
    Product(
      name: 'Redmi Note8 Pro',
      price: 19400,
      company: 'Redmin',
      ram: 6,
      storage: 128,
      discount: 12,
    ),

    //
    Product(
      name: 'Redmi 9',
      price: 9500,
      company: 'Redmi',
      ram: 2,
      storage: 32,
      discount: 20,
    ),

    //
    Product(
      name: 'Vivo Y3S',
      price: 9300,
      company: 'Vivo',
      ram: 2,
      storage: 32,
      discount: 10,
    ),

    //
    Product(
      name: 'Apple iPhone 12',
      price: 62000,
      company: 'Apple',
      ram: 6,
      storage: 128,
      discount: 5,
    ),
  ];
}
