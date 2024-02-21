
import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final Timestamp date;
  final Timestamp time;
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
