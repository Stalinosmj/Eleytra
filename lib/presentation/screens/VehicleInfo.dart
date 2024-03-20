import 'package:flutter/material.dart';

class VehicleInfo extends StatelessWidget {
  const VehicleInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Add Electric Vehicle Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Vehicle Name'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Vehicle Type (Car/Bike)'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Manufacturer'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year of Manufacture'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Battery Capacity (kWh)'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Range per Charge (miles/km)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logic to save vehicle info
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
