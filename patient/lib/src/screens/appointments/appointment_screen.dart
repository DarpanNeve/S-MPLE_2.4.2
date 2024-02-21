import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/doctor_chat/contact_doctor.dart';

import '../../constants/appointments.dart';
import '../../utils/strings_english.dart';
import 'book_appointment.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<Appointment> scheduledAppointments = [];
  final uid=FirebaseAuth.instance.currentUser!.uid;
   @override
  void initState() {
     fetchAppointments();
    super.initState();
  }
  Future<void> fetchAppointments() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("appointments")
        .where('uid', isEqualTo: uid)
        .get();
    querySnapshot.docs.forEach((doc) {
      scheduledAppointments.add(Appointment(
        date: doc['timestamp'],
        time: doc['timestamp'],
        hospital: doc['hospital'],
        doctor: doc['doctor'],
        reason: doc['reason'],
      ));
      print('appointments :${doc.data()}');
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'addAppointment',
            label:  Text(addAppointments),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),

          FloatingActionButton.extended(
            heroTag: 'contactDoctor',
            label:  Text(callADoctor),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const ContactDoctor();
                  },
                ),
              );
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scheduleAppointments,
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
                      title: Text('$appointments ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${appointment.date.toDate()}'),
                          // Text('$date: ${appointment.date.substring(0,10)}'),
                          Text('$hospitalHeader: ${appointment.hospital}'),
                          Text('$doctor: ${appointment.doctor}'),
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
