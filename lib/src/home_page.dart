import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/doctor_chat/appointment_screen.dart';
import 'package:medi_connect/src/screens/emergency_screen.dart';
import 'package:medi_connect/src/screens/map/hospital_locator.dart';
import 'package:medi_connect/src/screens/map/nearby_hospital.dart';
import 'package:medi_connect/src/screens/profile/profile_page.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final currentUser = FirebaseAuth.instance.currentUser;
  final List<Widget> _tabs = [
    map(),
    // NearbyHospital(),
    const AppointmentScreen(),
    const EmergencyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medi Connect'),
        actions:[
          if (currentUser != null && currentUser!.photoURL != null)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser!.photoURL!,
                  ),
                ),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Hospitals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos),
            label: 'Emergency',
          ),
        ],
      ),
    );
  }
}
