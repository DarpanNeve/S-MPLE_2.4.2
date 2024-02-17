import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/appointmentscreen.dart';
import 'package:medi_connect/src/screens/hospitalscreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index of the selected tab

  // List of tabs/pages
  final List<Widget> _tabs = [
    // Replace these with your actual pages/screens
    HospitalScreen(), // Hospital screen
    AppointmentScreen(), // Appointment Tracking screen
    Placeholder(), // Emergency Assistance screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex], // Display the selected tab/page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Update the selected tab index when a tab is tapped
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital), // Medical Records icon
            label: 'Hospitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event), // Appointment Tracking icon
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos), // Emergency Assistance icon
            label: 'Emergency',
          ),
        ],
      ),
    );
  }
}
