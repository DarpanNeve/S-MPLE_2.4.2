class Hospital {
  String name;
  double latitude;
  double longitude;
  String elevation;
  String phone;
  String website;
  double reviews;
  List<Rating> ratings;

  Hospital({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.phone,
    required this.website,
    required this.reviews,
    required this.ratings,
  });

  // Add the factory method and toJson method as shown in the previous implementation

  // Add a fromJson method to parse the data retrieved from Firebase
  factory Hospital.fromJson(Map<String, dynamic> json) {
    List<Rating> ratings = [];
    if (json['ratings'] != null) {
      json['ratings'].forEach((ratingJson) {
        ratings.add(Rating.fromJson(ratingJson));
      });
    }
    return Hospital(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      phone: json['phone'],
      website: json['website'],
      reviews: json['reviews'],
      ratings: ratings,
    );
  }
}

class Rating {
  String uid;
  String userName;
  double rating;
  String comment;

  Rating({
    required this.uid,
    required this.userName,
    required this.rating,
    required this.comment,
  });

  // Add toJson method to convert Rating object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'rating': rating,
      'comment': comment,
    };
  }

  // Add fromJson method to parse the data retrieved from Firebase
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      uid: json['uid'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}