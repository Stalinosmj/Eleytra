import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedVehicle = 'Tesla Model X'; // This will be updated with Firestore data
  List<String> vehicles = []; // Initialize an empty list for vehicles

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('vehicles')
          .where('ownerEmail', isEqualTo: firebaseUser.email)
          .get();
      setState(() {
        vehicles = querySnapshot.docs
            .map((doc) => doc.data()['name'] as String)
            .toList();
        if (vehicles.isNotEmpty) {
          selectedVehicle = vehicles.first; // Set the default vehicle
        }
      });
    }
  }

  void _changeVehicle() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              setState(() {
                selectedVehicle = vehicles[index];
              });
            },
            children: vehicles.map((String name) {
              return Center(child: Text(name));
            }).toList(),
          ),
        );
      },
    );
  }


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Charging Slot'),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 60),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.directions_car),
                title: const Text('Vehicle Information'),
                subtitle: Text(selectedVehicle),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _changeVehicle,
                ),
              ),
            ),
            const SizedBox(height: 70),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'Selected time: ${selectedTime.format(context)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 60),
            CupertinoButton.filled(
              onPressed: () {},
              child: const Text('Book EV Point'),
            ),
          ],
        ),
      ),
    );
  }
}
