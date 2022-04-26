import 'package:flutter/material.dart';
import 'package:native_feature/Homepage.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "ubuntu"),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
