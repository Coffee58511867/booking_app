import 'package:booking_app/products.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Products> product = [
    Products(id: 'Pro1', productName: 'Laptop', productPrice: 45.0),
    Products(id: 'Pro1', productName: 'Laptop', productPrice: 45.0),
    Products(id: 'Pro1', productName: 'Laptop', productPrice: 45.0),
    Products(id: 'Pro1', productName: 'Laptop', productPrice: 45.0),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text("List"),
            centerTitle: true,
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false),
        body: ListView(
          children: product.map((pro) {
            return Card(
              child: Row(
                children: [
                  Container(
                    child: Text(pro.productName),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
