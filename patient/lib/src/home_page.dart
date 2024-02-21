import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/appointments/appointment_screen.dart';
import 'package:medi_connect/src/screens/emergency_screen.dart';
import 'package:medi_connect/src/screens/map/hospital_locator.dart';
import 'package:medi_connect/src/screens/map/nearby_hospital.dart';
import 'package:medi_connect/src/screens/profile/profile_page.dart';
import 'package:medi_connect/src/utils/convertToEnglish.dart';
import 'package:medi_connect/src/utils/strings_english.dart';


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
  String langaugeCodeMain = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
        actions: [
          Row(
            children: [
              DropdownButton<String>(
                onChanged: (String? languageCode) {
                  langaugeCodeMain = languageCode!;
                  if (languageCode == 'en') {
                    convertToEnglish();
                  }
                  else {
                    convertToMarathi();
                  }
                  setState(() {});
                },
                items: <String>['en', 'mr'] // Example language codes
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: langaugeCodeMain,
              ),
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

          )
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: hospitalHeader,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: appointments,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos),
            label: emergency,
          ),
        ],
      ),
    );
  }
}
