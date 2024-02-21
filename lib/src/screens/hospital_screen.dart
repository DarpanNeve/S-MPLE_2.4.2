import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/login/auth_service.dart';

import '../utils/strings_english.dart';

class HospitalScreen extends StatelessWidget {
  const HospitalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(hospitalHeader),
        actions: [
          IconButton(
            onPressed: () {
              AuthService().signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey, // Placeholder color for the map
                  // Replace the color with your map widget
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16, // Adjust the position as needed
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle booking appointment button press
                  },
                  child: Text(bookAppointment),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
