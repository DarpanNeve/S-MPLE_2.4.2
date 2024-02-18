import 'package:flutter/material.dart';

import 'book_appointment.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Appointment'),
        onPressed: () {
          // Handle adding a new appointment
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const BookAppointmentScreen();
                // return const BookAppointmentScreen(onAppointmentBooked: ,);
              },
            ),
          );
        },
        icon: const Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduled Appointments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: ListView.builder(
                  itemCount: 5, // Replace with the actual number of scheduled appointments
                  itemBuilder: (BuildContext context, int index) {
                    // Replace the demo data with your actual appointment data
                    return ListTile(
                      title: Text('Appointment ${index + 1}'),
                      subtitle: Text('Date: YYYY-MM-DD, Time: HH:MM'),
                      onTap: () {
                        // Handle tapping on a scheduled appointment
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Past Appointments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueGrey),
                ),
                child: ListView.builder(
                  itemCount: 3, // Replace with the actual number of past appointments
                  itemBuilder: (BuildContext context, int index) {
                    // Replace the demo data with your actual appointment data
                    return ListTile(
                      title: Text('Appointment ${index + 1}'),
                      subtitle: Text('Date: YYYY-MM-DD, Time: HH:MM'),
                      onTap: () {
                        // Handle tapping on a past appointment
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
