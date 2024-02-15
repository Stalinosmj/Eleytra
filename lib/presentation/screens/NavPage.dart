import 'package:eleytra/presentation/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class NavPage extends StatefulWidget {
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
  void onCameraMove(CameraPosition cameraPosition) {
    debugPrint('${cameraPosition}');
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: const MarkerId("marker_1"),
          position: _currentLocation,
          infoWindow: const InfoWindow(title: 'Bharata Mata College'),
          rotation: 0),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(10.077260, 76.315545),
        infoWindow: InfoWindow(title: 'Vazhathottam'),
      ),
    };
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
        radius: 5000,
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
          onMapCreated: (controller){
            _controller = controller;
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          compassEnabled: true,
          markers: _createMarker(),
          mapToolbarEnabled: false,
          buildingsEnabled: true,
          onTap: (latLong) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Can't display Info")));
          },
          rotateGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          liteModeEnabled: false,
          circles: _createCircle(),
          //polygons: _createPolygon(),
          //polylines: _createPolyline(),
          trafficEnabled: true,
          onCameraMove: onCameraMove,
        ),
        Positioned(
          top:50,left: 15,
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
                  MaterialPageRoute(builder: (context) =>  const HomeScreen()),
                );
              },
            ),
          ),
        ),
      ]);
    }));
  }
}
