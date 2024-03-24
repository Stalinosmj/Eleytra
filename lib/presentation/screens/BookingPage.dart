import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  final int stationId;
  const BookingPage({Key? key, required this.stationId}) : super(key: key);

  @override
  State<BookingPage> createState()  => _BookingPageState(stationId);
}

class _BookingPageState extends State<BookingPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedVehicle =
      'Tesla Model X'; // This will be updated with Firestore data
  List<String> vehicles = []; // Initialize an empty list for vehicles
  String refId = ''; // This will hold the booking reference ID
  bool isBookingConfirmed = false;
  bool isCardVisible = false;
  late int _stationId;

  _BookingPageState(int stationId);

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
    _stationId = widget.stationId;
  }

  // Function to send the selected time to Firestore
  void _sendSelectedTimeToFirestore() async {
    // Assuming you have a function to get the current user's email
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Convert the TimeOfDay to a DateTime object
    final now = DateTime.now();
    final selectedDateTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    // Create a map of the data you want to send
    final Map<String, dynamic> bookingData = {
      'userEmail':
          userEmail, // Include the user's email to identify the booking
      'selectedTime': selectedDateTime, // Firestore can store DateTime objects
      // Add any other booking details here
      'stationId' : _stationId,
    };

    // Send the data to Firestore
    final CollectionReference bookings =
        FirebaseFirestore.instance.collection('bookings');
    await bookings.add(bookingData).then((docRef) {
      setState(() {
        refId = docRef.id; // Set the state variable with the new booking ID
        isBookingConfirmed = true;
      });
      print('Booking created with ID: $refId');
    }).catchError((error) {
      print('Error adding booking: $error');
    });
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Book Your Charging Slot'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Selected time: ${selectedTime.format(context)}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text('Select Time'),
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                onPressed: _sendSelectedTimeToFirestore,
                child: const Text('Book EV Point'),
              ),
              if (refId != '') // This will check if the booking has been confirmed
                SingleChildScrollView(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.check_circle_outline,
                                size: 50, color: Colors.green),
                            title: Text('Booking Confirmed',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                'Your EV point has been successfully booked.\nPlease Save this card in your device'),
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text('Booking ID'),
                            subtitle:
                                Text(refId), // Use the state variable here
                          ),
                          ListTile(
                            title: const Text('Vehicle'),
                            subtitle: Text(
                                selectedVehicle), // Replace with your variable
                          ),
                          ListTile(
                            title: const Text('Time'),
                            subtitle: Text(selectedTime
                                .format(context)), // Replace with your variable
                          ),
                          // Add more details if needed
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
