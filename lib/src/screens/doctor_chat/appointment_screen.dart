import 'package:flutter/material.dart';

import '../../constants/appointments.dart';
import 'book_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/appointments.dart';
import 'book_appointment.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<Appointment> scheduledAppointments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Appointment'),
        onPressed: () async {
          final appointment = await Navigator.of(context).push<Appointment>(
            MaterialPageRoute(
              builder: (context) {
                return const BookAppointmentScreen();
              },
            ),
          );
          if (appointment != null) {
            setState(() {
              scheduledAppointments.add(appointment);
            });
          }
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
                  itemCount: scheduledAppointments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final appointment = scheduledAppointments[index];
                    return ListTile(
                      title: Text('Appointment ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${appointment.date}, Time: ${appointment.time}'),
                          Text('Hospital: ${appointment.hospital}'),
                          Text('Doctor: ${appointment.doctor}'),
                        ],
                      ),
                      onTap: () {
                        // Handle tapping on a scheduled appointment
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
