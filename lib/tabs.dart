import 'package:booking_app/ecocash.dart';
import 'package:booking_app/mpesa.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Payments"),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(text: "Mpesa"),
              Tab(text: "Ecocash"),
            ]),
          ),
          body: const TabBarView(
            children: [MpesaPage(), EcocashPage()],
          ),
        ),
      );
}
