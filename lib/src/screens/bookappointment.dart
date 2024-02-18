import 'package:flutter/material.dart';

import '../constants/appointments.dart';


class BookAppointmentScreen extends StatefulWidget {
  final Function(Appointment) onAppointmentBooked;

  const BookAppointmentScreen({super.key, required this.onAppointmentBooked});

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedDoctor;
  String _appointmentReason = '';
  String? _selectedHospital;

  final List<String> hospitals = [
    'Hospital A',
    'Hospital B',
    'Hospital C',
  ];

  final List<String> doctors = [
    'Dr. John Doe',
    'Dr. Jane Smith',
    'Dr. Michael Johnson',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)), // Can be customized
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _submitAppointment() {
    // Validate and submit appointment
    if (_selectedDate != null &&
        _selectedTime != null &&
        _selectedDoctor != null &&
        _selectedHospital != null &&
        _appointmentReason.isNotEmpty) {
      // Create a new Appointment object
      Appointment newAppointment = Appointment(
        date: _selectedDate!,
        time: _selectedTime!,
        doctor: _selectedDoctor!,
        hospital: _selectedHospital!,
        reason: _appointmentReason,
      );

      // Invoke the callback function with the new appointment
      widget.onAppointmentBooked(newAppointment);

      // Reset fields after submission
      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _selectedDoctor = null;
        _selectedHospital = null;
        _appointmentReason = '';
      });

      // Navigate back to the previous screen (HospitalScreen)
      Navigator.pop(context);
    } else {
      // Handle validation errors or missing information
      // Show error message or prompt user to fill all fields
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 16.0),
            if (_selectedDate != null)
              Text(
                'Selected Date: ${_selectedDate!.toLocal()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
            const SizedBox(height: 16.0),
            if (_selectedTime != null)
              Text(
                'Selected Time: ${_selectedTime!.format(context)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedHospital,
              onChanged: (newValue) {
                setState(() {
                  _selectedHospital = newValue;
                });
              },
              items: hospitals.map((hospital) {
                return DropdownMenuItem<String>(
                  value: hospital,
                  child: Text(hospital),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Hospital',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedDoctor,
              onChanged: (newValue) {
                setState(() {
                  _selectedDoctor = newValue;
                });
              },
              items: doctors.map((doctor) {
                return DropdownMenuItem<String>(
                  value: doctor,
                  child: Text(doctor),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Doctor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Reason for Appointment',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  _appointmentReason = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitAppointment,
              child: const Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}