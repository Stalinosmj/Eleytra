
import 'package:eleytra/presentation/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:eleytra/database/charging_stations.dart';


class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  _NavMapState createState() => _NavMapState();
}

class _NavMapState extends State<NavPage> {
  late GoogleMapController _controller;
  LatLng _currentLocation = const LatLng(10.077260, 76.315545);
//Default Location - "Vazhathottam"

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void justPrint() {
    print("Working");
  }

  void goToMyLocation() {
    _controller.animateCamera(
      CameraUpdate.newLatLng(_currentLocation),
    );
  }

  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('$cameraPosition');
  }

  Set<Circle> _createCircle() {
    return {
      Circle(
        circleId: const CircleId('1'),
        consumeTapEvents: true,
        strokeColor: Colors.teal,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeWidth: 2,
        center: _currentLocation,
        radius: 10000,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _currentLocation,
            zoom: 14.0,
          ),
          onMapCreated: (controller) {
            _controller = controller;
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          compassEnabled: true,
          markers: Set.from(myMarkers),
          mapToolbarEnabled: false,
          buildingsEnabled: true,
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          liteModeEnabled: false,
          circles: _createCircle(),
          trafficEnabled: true,
          onCameraMove: onCameraMove,


        ),
        Positioned(
          top: 50,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 15,
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(25)),
              width: 40,
              height: 150,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      var currentZoomLevel = await _controller.getZoomLevel();
                      currentZoomLevel += 2;
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: _currentLocation, zoom: currentZoomLevel),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 3),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () async {
                      var currentZoomLevel = await _controller.getZoomLevel();
                      currentZoomLevel -= 2;
                      if (currentZoomLevel < 0) currentZoomLevel = 0;
                      _controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: _currentLocation, zoom: currentZoomLevel),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location_sharp),
                    onPressed: goToMyLocation,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.charging_station_rounded,
                color: Colors.black,
              ),
              onPressed: justPrint,
            ),
          ),
        ),
      ]);
    }));
  }
}
