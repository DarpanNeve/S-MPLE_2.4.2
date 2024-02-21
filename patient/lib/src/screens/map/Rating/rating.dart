import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/map/hospital_model.dart';
import 'package:medi_connect/src/utils/strings_english.dart';

class GiveRating extends StatefulWidget {
  final Hospital hospital;
  const GiveRating({Key? key, required this.hospital}) : super(key: key);

  @override
  State<GiveRating> createState() => _GiveRatingState();
}

class _GiveRatingState extends State<GiveRating> {
  double _rating = 0.0;
  String _comment = '';
  void submitRatingAndComment() {
    if (_rating > 0 && _comment.isNotEmpty) {
      DatabaseReference hospitalRef;
      if (widget.hospital.name != null) {
        // Use hospital ID if available
        hospitalRef = FirebaseDatabase.instance.ref('${widget.hospital.name}');
      } else {
        // Fallback to using hospital name
        hospitalRef = FirebaseDatabase.instance.ref('Hospital/${widget.hospital.name}');
      }

      // Create a map to represent the new rating data
      Map<String, dynamic> newRatingData = {
        'uid': FirebaseAuth.instance.currentUser!.uid, // You can replace 'user_id_here' with the actual user ID
        'name': FirebaseAuth.instance.currentUser!.displayName, // You can replace 'user_name_here' with the actual user name
        'rating': _rating,
        'comment': _comment,
      };

      hospitalRef.child('ratings').push().set(newRatingData).then((_) {
        // Successfully uploaded
        print('Rating and comment submitted successfully.');
        Navigator.pop(context);
      }).catchError((error) {
        // Error occurred
        print('Error submitting rating and comment: $error');
      });
    } else {
      // Handle case where rating or comment is not provided
      print('Please provide a rating and comment.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(giveRating),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rate ${widget.hospital.name}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Slider(
                value: _rating,
                onChanged: (newValue) {
                  setState(() {
                    _rating = newValue;
                  });
                },
                min: 0,
                max: 5,
                divisions: 5,
                label: _rating.toStringAsFixed(1),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: comments,
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _comment = value;
                  });
                },
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Submit the rating and comment
          
                  print('Rating: $_rating, Comment: $_comment');
                  submitRatingAndComment();
                  // You can add logic here to submit the rating and comment to a database
                },
                child: Text(submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
