import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

class positionScreen extends StatefulWidget {
  const positionScreen({super.key});

  @override
  State<positionScreen> createState() => _positionScreenState();
}

class _positionScreenState extends State<positionScreen> {
  var locationLatitude = ""; //kendi eylem değerimiz
  var locationLongitude = ""; //kendi boylam değerimiz
  var targetLati = "0"; //hedef eylem değeri
  var targetLong = "0"; //hedef boylam değeri

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      locationLatitude = "${position.latitude}";
      locationLongitude = "${position.longitude}";
    });
  }

  String distance = "-";

  getDistance() {
    double distanceInMeters = Geolocator.distanceBetween(
        double.parse(locationLatitude),
        double.parse(locationLongitude),
        double.parse(targetLati),
        double.parse(targetLong));

    if (distanceInMeters < 1000) {
      distance = "${distanceInMeters.toStringAsFixed(2)} metre";
    } else {
      distance = "${((distanceInMeters / 1000).toStringAsFixed(2))} km";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Location with Geolocator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 50,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Get User Location",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("latitude: $locationLatitude"),
            Text("longitude: $locationLongitude"),
            TextButton(
                onPressed: () {
                  getCurrentLocation();
                },
                child: const Text("Get Current Location")),
            const Divider(thickness: 2, color: Colors.black),
            const Text(
              "Target Locate",
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Target Latitude"),
              onChanged: (value) {
                if (value.isEmpty) {
                  targetLati = "";
                } else {
                  targetLati = value;
                }
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Target Longitude",
              ),
              onChanged: (value) {
                targetLong = value;
              },
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    getDistance();
                  });
                },
                child: const Text("Calculate Distance Between Locations")),
            Text(distance)
          ],
        ),
      ),
    );
  }
}
