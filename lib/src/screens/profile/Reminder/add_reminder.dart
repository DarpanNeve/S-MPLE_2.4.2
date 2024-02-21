import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../feature/fcm/notification_initialiser.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  String? _selectedOption;
  TimeOfDay? _selectedTime;
  TextEditingController _textEditingController = TextEditingController();

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
  void _submitReminder() async {
    if (_selectedOption != null &&
        _selectedTime != null &&
        _textEditingController.text.isNotEmpty) {
      debugPrint('Creating combined DateTime...');
      final DateTime combinedDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      debugPrint('Combined DateTime: $combinedDateTime');

      Timestamp appointmentTimestamp = Timestamp.fromDate(combinedDateTime);

      debugPrint('Setting reminder document in Firestore...');
      await FirebaseFirestore.instance.collection('reminder').doc(appointmentTimestamp.toString()).set({
        'option': _selectedOption,
        'time': _selectedTime,
        'text': _textEditingController.text,
        'timestamp': appointmentTimestamp,
        'uid': FirebaseAuth.instance.currentUser!.uid,
      });

      debugPrint('Scheduling notification...');
      await notification().scheduleNotification(combinedDateTime,
          _selectedOption!, _textEditingController.text, true);

      setState(() {
        // _selectedTime = null;
        // _textEditingController.text = '';
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
        title: Text('Add Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Select an option'),
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
              items: <String>[
                'Intake Reminder',
                'Dosage Instructions',
                'Refill Alerts',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (_selectedOption == 'Intake Reminder' ||
                _selectedOption == 'Dosage Instructions' ||
                _selectedOption == 'Refill Alerts')
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter ${_selectedOption?.toLowerCase()}',
                  border: OutlineInputBorder(),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Select Time'),
            ),
            SizedBox(height: 20),
            if (_selectedTime != null)
              Text(
                'Selected Time: ${_selectedTime!.format(context)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement your logic to handle the user input
                // You can access the input value using _textEditingController.text
                _submitReminder();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
