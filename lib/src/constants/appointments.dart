import 'package:flutter/material.dart';

class Appointment {
  final DateTime date;
  final TimeOfDay time;
  final String hospital;
  final String doctor;
  final String reason;

  Appointment({
    required this.date,
    required this.time,
    required this.hospital,
    required this.doctor,
    required this.reason,
  });
}
