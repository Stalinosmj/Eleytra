import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleInfo extends StatelessWidget {
  VehicleInfo({Key? key}) : super(key: key);

  // Create controllers for each text field to capture input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _batteryCapacityController = TextEditingController();
  final TextEditingController _rangeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Add Electric Vehicle Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Vehicle Name'),
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Vehicle Type (Car/Bike)'),
              ),
              TextFormField(
                controller: _manufacturerController,
                decoration: const InputDecoration(labelText: 'Manufacturer'),
              ),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year of Manufacture'),
              ),
              TextFormField(
                controller: _batteryCapacityController,
                decoration: const InputDecoration(labelText: 'Battery Capacity (kWh)'),
              ),
              TextFormField(
                controller: _rangeController,
                decoration: const InputDecoration(labelText: 'Range per Charge (miles/km)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (userEmail != null) {
                    // Create a map of the vehicle info including the user's email
                    final vehicleInfo = {
                      'name': _nameController.text,
                      'type': _typeController.text,
                      'manufacturer': _manufacturerController.text,
                      'model': _modelController.text,
                      'year': int.tryParse(_yearController.text),
                      'batteryCapacity': double.tryParse(_batteryCapacityController.text),
                      'range': _rangeController.text,
                      'ownerEmail': userEmail, // Add the user's email here
                    };

                    // Save the vehicle info to Firestore
                    await FirebaseFirestore.instance.collection('vehicles').add(vehicleInfo);

                    // Clear the text fields after saving
                    _nameController.clear();
                    _typeController.clear();
                    _manufacturerController.clear();
                    _modelController.clear();
                    _yearController.clear();
                    _batteryCapacityController.clear();
                    _rangeController.clear();
                  } else {
                    // Handle the case where there is no user email
                    // This could be showing an error message or prompting for login
                  }
                },
                child: const Text('Save Vehicle Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
