import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/fcm/notification_initialiser.dart';
import 'package:medi_connect/src/utils/strings_english.dart';


class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({Key? key});

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
    dhanwantiHospitalNigdi,
    pdaAyurvedicHospital,
    diwanHospitalPune,
  ];

  final List<String> doctors = [
    doctorA,
    doctorB,
    doctorC
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

  void _submitAppointment() async {
    if (_selectedDate != null &&
        _selectedTime != null &&
        _selectedDoctor != null &&
        _selectedHospital != null &&
        _appointmentReason.isNotEmpty) {
      final DateTime combinedDateTime =await DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      Timestamp appointmentTimestamp = Timestamp.fromDate(combinedDateTime);

      await FirebaseFirestore.instance.collection('appointments').doc(appointmentTimestamp.toString()).set({
        'doctor': _selectedDoctor,
        'hospital': _selectedHospital,
        'reason': _appointmentReason,
        'timestamp': appointmentTimestamp,
        'uid':FirebaseAuth.instance.currentUser!.uid,
      });
      await notification().scheduleNotification(combinedDateTime,"It's time for the appointment!","Appointment Reminder",false);
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
          content: Text(pleaseFillAllFields),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(bookAppointment),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(selectDate),
            ),
            const SizedBox(height: 16.0),
            if (_selectedDate != null)
              Text(
                '$selectDate: ${_selectedDate!.toLocal()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text(selectTime),
            ),
            const SizedBox(height: 16.0),
            if (_selectedTime != null)
              Text(
                '$selectTime: ${_selectedTime!.format(context)}',
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
                decoration:  InputDecoration(
                  labelText: selectHospital,
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
              decoration:  InputDecoration(
                labelText: selectDoctor,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration:  InputDecoration(
                labelText: reasonForAppointment,
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
              child: Text(bookAppointment),
            ),
          ],
        ),
      ),
    );
  }
}
