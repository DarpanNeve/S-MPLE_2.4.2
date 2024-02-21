import 'package:flutter/material.dart';
import 'package:medi_connect/src/screens/map/hospital_model.dart';

class GiveRating extends StatefulWidget {
  final Hospital hospital;
  const GiveRating({Key? key, required this.hospital}) : super(key: key);

  @override
  State<GiveRating> createState() => _GiveRatingState();
}

class _GiveRatingState extends State<GiveRating> {
  double _rating = 0.0;
  String _comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Rating'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                labelText: 'Comment',
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
                // You can add logic here to submit the rating and comment to a database
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
