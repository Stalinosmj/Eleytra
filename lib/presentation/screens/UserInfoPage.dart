import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'VehicleInfo.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            // Center the Column widget
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center children vertically
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/OIP.pg1rqonYWmAv6wouQjRWtgHaHa?rs=1&pid=ImgDetMain"), // Replace with actual image URL
                ),
                const SizedBox(height: 20),
                Text(
                  user?.email ??
                      'No email available', // Display user's email from Firebase Auth
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center, // Center the text horizontally
                ),
                // Other profile details can be added here
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('vehicles')
                        .where('ownerEmail', isEqualTo: userEmail)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> vehicle =
                                document.data()! as Map<String, dynamic>;
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: ListTile(
                                leading: const Icon(Icons
                                    .directions_car), // Replace with an appropriate icon
                                title: Text(
                                  vehicle['name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Type: ${vehicle['type']}'),
                                      Text(
                                          'Manufacturer: ${vehicle['manufacturer']}'),
                                      Text('Model: ${vehicle['model']}'),
                                      Text(
                                          'Year: ${vehicle['year'].toString()}'),
                                      Text(
                                          'Battery Capacity: ${vehicle['batteryCapacity'].toString()} kWh'),
                                      Text('Range: ${vehicle['range']}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text('No vehicles found');
                      }
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add your onPressed logic here
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VehicleInfo()),
                    );
                  },
                  icon: const Icon(Icons.add), // "+" icon
                  label: const Text(
                      'Add Vehicle'), // You can leave this empty if you just want the icon
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text and icon color
                    elevation: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
