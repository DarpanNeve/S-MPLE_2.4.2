import 'package:flutter/material.dart';

// Define the Appointment class
class Appointment {
  final String title;
  final DateTime dateTime;

  Appointment({required this.title, required this.dateTime});
}

class Appointments extends StatefulWidget {
  final String doctorId; // The ID of the doctor
  const Appointments({Key? key, required this.doctorId}) : super(key: key);

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  List<Appointment> appointments = []; // List to store the doctor's appointments

  @override
  void initState() {
    super.initState();
    // Fetch the doctor's appointments when the widget initializes
    fetchAppointments();
  }

  // Function to fetch the doctor's appointments
  void fetchAppointments() {
    // Here you would typically fetch the appointments for the given doctorId
    // For demonstration purposes, we'll just hardcode some appointments
    appointments = [
      Appointment(title: 'Appointment 1', dateTime: DateTime(2024, 3, 10, 10, 0)),
      Appointment(title: 'Appointment 2', dateTime: DateTime(2024, 3, 15, 14, 30)),
      Appointment(title: 'Appointment 3', dateTime: DateTime(2024, 3, 20, 9, 0)),
    ];

    // Set the state to trigger a UI update with the fetched appointments
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: appointments.isEmpty // Check if appointments list is empty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator if appointments are being fetched
          : ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text(appointment.title),
            subtitle: Text('${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year} ${appointment.dateTime.hour}:${appointment.dateTime.minute}'),
          );
        },
      ),
    );
  }
}
