import 'dart:io';

import 'package:flutter/material.dart';

class gallaryScreen extends StatelessWidget {
  Color darkthemeColor = Color(0XFF121212);
  List<File> images = [];
  gallaryScreen({required this.images});
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
      body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: images
              .map((e) => Image.file(
                    e,
                    fit: BoxFit.cover,
                  ))
              .toList()),
    );
  }
}
