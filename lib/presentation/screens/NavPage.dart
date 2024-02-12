import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';


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

  final _places = GoogleMapsPlaces(apiKey: 'AIzaSyCZCCDltKMqDbo0YrO0sT-IVGSDqWbo0OY');

  Future<List<PlacesSearchResult>> searchPlaces(String query, LatLng location) async {
    final result = await _places.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      5000,
      type: "restaurant",
      keyword: query,
    );
    if (result.status == "OK") {
      return result.results;
    } else {
      throw Exception(result.errorMessage);
    }
  }



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
        body: ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            final place = result[index];
            return ListTile(
              title: Text(place.name),
              subtitle: Text(place.vicinity),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => openDetailsScreen(context, place),
              ),
            );
          },
        );


    );
  }
}