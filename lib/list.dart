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
            return Container(
              margin: const EdgeInsets.only(top: 16.0, left: 32.0, right: 32.0),
              child: Card(
                // color: Colors.blue[300],
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16.0, left: 8.0),
                      height: 34,
                      child: Text(
                        pro.productName,
                        style: const TextStyle(
                            fontFamily: AutofillHints.addressState,
                            fontSize: 18.0,
                            // color: Colors.white54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16.0, left: 16.0),
                      height: 34,
                      child: Text(
                        pro.productName,
                        style: const TextStyle(
                            fontFamily: AutofillHints.addressState,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
