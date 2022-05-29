import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app/frontend/dependentsizes.dart';

class GpsTest extends StatelessWidget {
  const GpsTest({Key? key}) : super(key: key);

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Current position: " + position.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test of geolocator"),
        ),
        body: Scrollbar(
          child: ListView(
            padding: EdgeInsets.all(defaultPadding(context)),
            children: [
              ElevatedButton(
                onPressed: _getLocation,
                child: const Text("Get GPS Location"),
              ),
            ],
          ),
        ));
  }
}
