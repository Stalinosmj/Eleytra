import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {

  // in the below line, we are initializing our controller for google maps.
  final Completer<GoogleMapController> _controller = Completer();

  // in the below line, we are specifying our camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(10.030418, 76.335059),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // in the below line, we are specifying our app bar.
        appBar: AppBar(
          // setting background color for app bar
          backgroundColor: const Color(0xFF0F9D58),
          // setting title for app bar.
          title: const Text("Charging Stations"),
        ),
        body: GoogleMap(
          // in the below line, setting camera position
          initialCameraPosition: _kGoogle,
          // in the below line, specifying map type.
          mapType: MapType.normal,
          // in the below line, setting user location enabled.
          myLocationEnabled: true,
          // in the below line, setting compass enabled.
          compassEnabled: true,
          // in the below line, specifying controller on map complete.
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        )

    );
  }
}