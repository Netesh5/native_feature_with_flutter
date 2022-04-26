import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_feature/Services/CameraService/cameraScreen.dart';
import 'package:native_feature/Services/MapHomepage.dart';

class HomePage extends StatelessWidget {
  Color darkthemeColor = Color(0XFF121212);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Native features",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkthemeColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => mapHomepage()));
                },
                child: const Text("Map service")),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  availableCameras().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => cameraScreen(camera: value))));
                },
                child: const Text("Camera service")),
          ],
        ),
      ),
    );
  }
}
