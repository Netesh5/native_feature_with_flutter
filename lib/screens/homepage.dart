import 'package:flutter/material.dart';
import 'package:native_feature/models/geolocatorModel.dart';
import 'package:native_feature/screens/mapScreen.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Color darkthemeColor = Color(0XFF121212);

  geoLocator _locator = geoLocator();
  String longitude = "";
  String latitude = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<geoLocator>(
      create: (context) => geoLocator(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Location Services",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: darkthemeColor,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 300,
                ),
                Consumer<geoLocator>(
                  builder: (context, value, child) => ElevatedButton(
                      onPressed: () {
                        value.getCurrentLocation();
                      },
                      child: const Text("Get Current location")),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<geoLocator>(
                  builder: (context, geoLocator, child) => Text(
                    "Longitude : ${geoLocator.longitude}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<geoLocator>(
                  builder: (context, geoLocator, child) => Text(
                    "Latitude : ${geoLocator.latitude}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => mapScreen()));
                    },
                    child: const Text("Show in map"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
