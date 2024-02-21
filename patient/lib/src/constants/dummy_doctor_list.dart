class Doctor {
  final String name;
  final String specialization;
  final String location;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialization,
    required this.location,
    required this.imageUrl,
  });
}

List<Doctor> dummyDoctorList = [
  Doctor(
    name: 'Dr. John Doe',
    specialization: 'Cardiologist',
    location: '123 Main Street, Cityville',
    imageUrl: 'https://via.placeholder.com/150',
  ),
  Doctor(
    name: 'Dr. Jane Smith',
    specialization: 'Pediatrician',
    location: '456 Elm Street, Townsville',
    imageUrl: 'https://via.placeholder.com/150',
  ),
  Doctor(
    name: 'Dr. Michael Johnson',
    specialization: 'Dermatologist',
    location: '789 Oak Street, Villageton',
    imageUrl: 'https://via.placeholder.com/150',
  ),
  Doctor(
    name: 'Dr. Emily Brown',
    specialization: 'Orthopedic Surgeon',
    location: '101 Pine Street, Hilltop',
    imageUrl: 'https://via.placeholder.com/150',
  ),
  Doctor(
    name: 'Dr. David Lee',
    specialization: 'Psychiatrist',
    location: '202 Maple Street, Riverside',
    imageUrl: 'https://via.placeholder.com/150',
  ),
];
