import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_feature/models/geolocatorModel.dart';
import 'package:provider/provider.dart';

class mapScreen extends StatefulWidget {
  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  Color darkthemeColor = Color(0XFF121212);
  Completer<GoogleMapController> _controller = Completer();

  geoLocator locator = geoLocator();

  static const CameraPosition initialPositon = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.0);

  Set<Marker> marker = {};

  @override
  void dispose() {
    _controller;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<geoLocator>(
      create: (context) => geoLocator(),
      child: Scaffold(
        floatingActionButton: Consumer<geoLocator>(
          builder: (context, value, child) => FloatingActionButton.extended(
            onPressed: () async {
              Position? currentPosition = await value.getCurrentLocation();
              double lng = currentPosition!.longitude;
              double lat = currentPosition.latitude;
              CameraPosition targetPosition = CameraPosition(
                  target: LatLng(value.lat!, value.lng!), zoom: 17.0);
              getLocation(targetPosition);
              marker.clear();
              marker.add(Marker(
                  markerId: const MarkerId('currentPosition'),
                  infoWindow: const InfoWindow(title: "your location"),
                  position: LatLng(value.lat!, value.lng!)));
              setState(() {});
            },
            icon: const Icon(Icons.location_on),
            label: const Text("Get my location"),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Google Map",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: darkthemeColor,
        ),
        body: GoogleMap(
          initialCameraPosition: initialPositon,
          markers: marker,
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          trafficEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  Future<void> getLocation(targetPosition) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}
