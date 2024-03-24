
import 'package:eleytra/presentation/screens/NavPage.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ChargingStation {
  final int id;
  final String name;
  final String location;
  final String chargingAvailable;

  ChargingStation({required this.id,required this.name, required this.location, required this.chargingAvailable});
}

class Nav_Points extends StatelessWidget {
  List<ChargingStation> chargingStations = [
    ChargingStation(name: 'Kazam Charging Station', location: 'Cross Rd Number 7, Elamkulam', chargingAvailable: 'Yes', id: 1),
    ChargingStation(name: 'Ather Charging Station', location: 'Mahatma Gandhi Rd, Padma Junction', chargingAvailable: 'Yes', id: 2),
    ChargingStation(name: 'Zeon Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'Yes', id: 3),
    ChargingStation(name: 'KSEBL Palarivattom Charging Station', location: 'NH 66, Ponnurunni, Vyttila', chargingAvailable: 'Yes', id: 4),
    ChargingStation(name: 'United Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'No', id: 5),
    ChargingStation(name: 'Tata Power - Sree Gokulam Motors Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'Yes', id: 6),
    ChargingStation(name: 'Incheon Kia Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'Yes', id: 7),
    ChargingStation(name: 'Tata Power - Amritara The Poovath Heritage (Private -Charger)', location: 'River Rd, Fort Kochi', chargingAvailable: 'No', id: 8),
    ChargingStation(name: 'CESL - KTDC Tourist Charging Station', location: 'X7FH+QMX, Marine Drive', chargingAvailable: 'No', id: 9),
    ChargingStation(name: 'Cherthala South Charging Station', location: 'St. Marys Parish Hall, Muttom', chargingAvailable: 'Yes', id: 10),
    ChargingStation(name: 'Zeon Charging - Grand Mall Charging Station', location: 'St. Marys Parish Hall, Muttom', chargingAvailable: 'No', id: 11),
    ChargingStation(name: 'KSEBL Kakkanad Charging Station', location: 'Kakkanad, Kochi', chargingAvailable: 'Yes', id: 12),
    ChargingStation(name: 'Tata Power - Kalamassery Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'No', id: 13),
    ChargingStation(name: 'KSEBL Edappally Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'Yes', id: 14),
    ChargingStation(name: 'Zeon Charging - Lulu Mall Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'No', id: 15),
    ChargingStation(name: 'KSEBL Vyttila Charging Station', location: 'Cross Rd Number 7, Elamkulam', chargingAvailable: 'Yes', id: 16),
    ChargingStation(name: 'Ather Charging Station', location: 'Mahatma Gandhi Rd, Padma Junction', chargingAvailable: 'Yes', id: 17),
    ChargingStation(name: 'Zeon Charging - Oberon Mall Charging Station', location: 'Vattekunnam, Edappally', chargingAvailable: 'No', id: 18),
    ChargingStation(name: 'Tata Power - Nettoor Charging Station', location: 'X7FH+QMX, Marine Drive', chargingAvailable: 'No', id: 19),
  ];



  LatLng getLatLngByStationId(int stationId) {

    switch (stationId) {
      case 1:
        return LatLng(9.9696, 76.3003);
      case 2:
        return LatLng(9.9825, 76.2827);
      case 3:
        return LatLng(10.0405, 76.3109);
      case 4:
        return LatLng(9.9700, 76.3181);
      case 5:
        return LatLng(10.0405, 76.3109);
      case 6:
        return LatLng(10.0405, 76.3109);
      case 7:
        return LatLng(10.0405, 76.3109);
      case 8:
        return LatLng(9.9677, 76.2422);
      case 9:
        return LatLng(9.9749, 76.2797);
      case 10:
        return LatLng(9.6886, 76.3361);
      case 11:
        return LatLng(10.0405, 76.3109);
      case 12:
        return LatLng(10.0145, 76.3475);
      case 13:
        return LatLng(10.0405, 76.3109);
      case 14:
        return LatLng(10.0405, 76.3109);
      case 15:
        return LatLng(10.0405, 76.3109);
      case 16:
        return LatLng(9.9696, 76.3003);
      case 17:
        return LatLng(9.9825, 76.2827);
      case 18:
        return LatLng(10.0405, 76.3109);
      case 19:
        return LatLng(9.9749, 76.2797);
      default:
        return LatLng(9.9696, 76.3003); // Return null if the station ID is not found
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charging Stations',
      home: Scaffold(
        body: ListView.builder(
          itemCount: chargingStations.length,
          itemBuilder: (context, index) {
            final station = chargingStations[index];
            final LatLng charge_point = getLatLngByStationId(station.id);
            return ListTile(
              title: Text(station.name),
              subtitle: Text(station.location),
              trailing: Text('${station.chargingAvailable} '),
              onTap: () {
                // Handle station click (e.g., navigate to station details)
                Future.delayed(const Duration(milliseconds: 500));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                             NavPage(chargePoint: charge_point,stationId: station.id,)));

              },
            );
          },
        ),
      ),
    );
  }
}
