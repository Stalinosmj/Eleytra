import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://static.wikia.nocookie.net/kimetsu-no-yaiba/images/1/1e/Tanjiro_Kamado_%28Blood-Stench_Blade_Royale%29.png/revision/latest/scale-to-width-down/1000?cb=20200524143409"),
            ),
            SizedBox(height: 20),
            Text(
              'Pathalam Jude', // Replace with user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'pathalamjude@vazha.com', // Replace with user's email
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('+91 87144 65131'), // Replace with user's phone number
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Vazhathottam, Pathalam, India'), // Replace with user's address
            ),
          ],
        ),
      ),
    );
  }
}
