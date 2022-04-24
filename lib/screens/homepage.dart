import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Color darkthemeColor = Color(0XFF121212);
  String longitude = "";
  String latitude = "";

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint("permission not granted");
      LocationPermission askedPermission = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        longitude = currentPosition.longitude.toString();
        latitude = currentPosition.latitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Location Services",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkthemeColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            ElevatedButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: const Text("Get Current location")),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Longitude : ${longitude}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Latitude : ${latitude}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
