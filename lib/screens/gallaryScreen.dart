import 'package:flutter/material.dart';

class gallaryScreen extends StatelessWidget {
  Color darkthemeColor = Color(0XFF121212);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Gallary",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkthemeColor,
      ),
    );
  }
}
