class Hospital {
  String name;
  double latitude;
  double longitude;
  String elevation;
  String phone;
  String website;
  double reviews;

  Hospital({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.phone,
    required this.website,
    required this.reviews,
  });

  factory Hospital.fromMap(Map<dynamic, dynamic> map) {
    return Hospital(
      name: map['name'],
      latitude: double.parse(map['latitude'].toString()),
      longitude: double.parse(map['longitude'].toString()),
      elevation: map['elevation'],
      phone: map['phone'],
      website: map['website'],
      reviews: double.parse(map['reviews'].toString()),
    );
  }
}
