import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      child: const Text("Home Page"),
    );
  }
}
