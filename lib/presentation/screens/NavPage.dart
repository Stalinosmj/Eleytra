import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:geolocator/geolocator.dart';


import 'package:eleytra/presentation/screens/Nav_Points.dart';

class NavPage extends StatefulWidget {
  final LatLng chargePoint;

  const NavPage({Key? key, required this.chargePoint}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState(chargePoint);
}

class _NavPageState extends State<NavPage> {
  late LatLng myPoint;
  bool isLoading = false;
  LatLng _currentLocation = LatLng(10.030193, 76.334996);
  late LatLng _chargingpoint;

  _NavPageState(this._chargingpoint);



  @override
  void initState() {
    myPoint = defaultPoint;
    _chargingpoint = widget.chargePoint;
    super.initState();
    _getCurrentLocation();
  }
  final defaultPoint = LatLng(10.030418, 76.335059);

  List listOfPoints = [];
  List<LatLng> points = [];
  List<Marker> markers = [];

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }


  Future<void> getCoordinates(lat1) async {
    setState(() {
      isLoading = true;
    });

    final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62483a73d13d5a23433ca29bc1b1a099a3c2',
    );

    final List<ORSCoordinate> routeCoordinates =
        await client.directionsRouteCoordsGet(
      startCoordinate:
          ORSCoordinate(latitude: _currentLocation.latitude, longitude: _currentLocation.longitude),
      endCoordinate:
          ORSCoordinate(latitude: _chargingpoint.latitude, longitude: _chargingpoint.longitude),
    );

    final List<LatLng> routePoints = routeCoordinates
        .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
        .toList();

    setState(() {
      points = routePoints;
      isLoading = false;
    });
  }

  final MapController mapController = MapController();

  void _handleTap(LatLng latLng) {
    setState(() {
      if (markers.length < 2) {
        markers.add(
          Marker(
            point: _chargingpoint,
            width: 80,
            height: 80,
            builder: (context) => Draggable(
              feedback: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                color: Colors.black,
                iconSize: 45,
              ),
              onDragEnd: (details) {
                setState(() {
                  print(
                      "Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}");
                });
              },
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.location_on_outlined),
                color: Colors.black,
                iconSize: 45,
              ),
            ),
          ),
        );
      }

      if (markers.length == 1) {
        double zoomLevel = 16.5;
        mapController.move(latLng, zoomLevel);
      }

      if (markers.length < 2) {
        // Adicionar um pequeno atraso antes de exibir o efeito de processo
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = true;
          });
        });

        getCoordinates(_chargingpoint);

        // Calcular a extensão (bounding box) que envolve os dois pontos marcados
        LatLngBounds bounds = LatLngBounds.fromPoints(
            markers.map((marker) => marker.point).toList());
        // Fazer um zoom out para que a extensão se ajuste à tela
        mapController.fitBounds(bounds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              zoom: 16,
              center: _currentLocation,
              onTap: (tapPosition, latLng) => _handleTap(latLng),
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                markers: markers,
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: points,
                    color: Colors.black,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: isLoading,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 20.0,
            left: MediaQuery.of(context).size.width / 2 - 110,
            child: Align(
              child: TextButton(
                onPressed: () {
                  if (markers.isEmpty) {
                    // Se os marcadores estiverem vazios
                    print('Mark route on the map');
                  } else {
                    setState(() {
                      markers = [];
                      points = [];
                    });
                  }
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      markers.isEmpty ? "Mark route on the map" : "Clear Route",
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              mapController.move(mapController.center, mapController.zoom + 1);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              mapController.move(mapController.center, mapController.zoom - 1);
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
