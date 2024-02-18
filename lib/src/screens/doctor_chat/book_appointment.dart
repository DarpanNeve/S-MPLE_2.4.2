import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/snackbar.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({Key? key});

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}
Timestamp _selectedDateToTimestamp=Timestamp.now();

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedDoctor;
  String _appointmentReason = '';
  String? _selectedHospital;

  final List<String> hospitals = [
    'Dhanwantari Hospital Nigdi',
    'PDEAs Ayurveda Rugnalaya & Sterling Multi Speciality Hospital ARSMH',
    'Diwan Hospital Pune',
  ];

  final List<String> doctors = [
    'Dr. Sandeep Vaishya',
    'Dr. Naresh Trehan',
    'Dr. Aditya Gupta',
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
        _selectedDateToTimestamp=Timestamp.fromDate(pickedDate);
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

  void _submitAppointment() async {
    if (_selectedDate != null &&
        _selectedTime != null &&
        _selectedDoctor != null &&
        _selectedHospital != null &&
        _appointmentReason.isNotEmpty) {
      final DateTime combinedDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final int appointmentTimestamp = combinedDateTime.millisecondsSinceEpoch;

      await FirebaseFirestore.instance.collection('appointments').doc(appointmentTimestamp.toString()).set({
        'date': _selectedDate,
        'time': _selectedTime,
        'doctor': _selectedDoctor,
        'hospital': _selectedHospital,
        'reason': _appointmentReason,
        'timestamp': appointmentTimestamp,
      });

      setState(() {
        _selectedDate = null;
        _selectedTime = null;
        _selectedDoctor = null;
        _selectedHospital = null;
        _appointmentReason = '';
      });

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields.'),
          backgroundColor: Colors.red,
        ),
      );
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
            Container(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedHospital,
                onChanged: (newValue) {
                  setState(() {
                    _selectedHospital = newValue;
                  });
                },
                items: hospitals.map((hospital) {
                  return DropdownMenuItem<String>(
                    value: hospital,
                    child: Text(hospital,
                      overflow:TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Hospital',
                  border: OutlineInputBorder(),
                ),
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
