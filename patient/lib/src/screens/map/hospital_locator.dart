import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../utils/strings_english.dart';
import '../appointments/book_appointment.dart';
import 'ChatBot/chat_bot.dart';
import 'Rating/rating.dart';
import 'bloc/map_bloc.dart';
import 'hospital_model.dart';

class map extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<map> {
  final Completer<GoogleMapController> _controller = Completer();
  late LocationData locationData;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  void _showHospitalInfoBottomSheet(BuildContext context, Hospital hospital) async{

    final snapshot = await FirebaseDatabase.instance.ref(hospital.name).child('ratings').get();
    List<Rating> ratings = [];
    print('printing from snapshot ${snapshot.value}');
    if (snapshot.value != null){
      final Map<dynamic, dynamic>? dataMap = snapshot.value as Map<dynamic, dynamic>?;

      if (dataMap != null){
        dataMap.forEach((key, value) {
          ratings.add(
            Rating(
              uid: value['uid'] ?? '',
              userName: value['name'] ?? '',
              rating: (value['rating'] as num?)?.toDouble() ?? 0.0,
              comment: value['comment'] ?? '',
            ),
          );
        });
      }
    }
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: _buildHospitalInfo(hospital,context,ratings),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBot()));
        },
        label: Text(chatWithBot),
        icon: Icon(Icons.chat),

      ),
        body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoaded) {
            print("state data is printed ${state.hospitals}");
            return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: state.location,
                  zoom: 11.0,
                ),
                myLocationEnabled: true,
                markers: state.hospitals
                    .map((hospital) => Marker(
                  markerId: MarkerId(hospital.name),
                  position: LatLng(hospital.latitude, hospital.longitude),
                  infoWindow: InfoWindow(
                    title: hospital.name,
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, hospital);
                    },
                  ),
                ))
                    .toSet());
          }
          if(state is MapLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is MapError){
            return Center(
              child: Text(state.message),
            );
          }
          return Center(
            child: Container(
              child: GestureDetector(
                  onTap: (){
                    BlocProvider.of<MapBloc>(context).add(MapLoad());
                  },
                  child: Text(pressToLoadMap)),

            ),
          );
       },
       ),
      );
  }
}


Widget _buildHospitalInfo(Hospital hospital,BuildContext context,List<Rating> ratings) {
  return SingleChildScrollView(
    child: Container(
      width: MediaQuery.of(context).size.width*1,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                hospital.name,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('$rating: ${hospital.reviews}'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('$phone: ${hospital.phone}'),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('$website: ${hospital.website}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointmentScreen()));
    
                    },
                    child: Text(bookAppointment)
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GiveRating(hospital: hospital,)));

                    },
                    child: Text(giveRating)
                ),
              ],
            ),
            Column(
              children: ratings.map((rating) {
                return ListTile(
                  title: Text(rating.userName),
                  subtitle: Text(rating.comment),
                  trailing: Text(rating.rating.toString()),
                );
              }).toList(),
            )
            // Add more information as needed
          ],
        ),
      ),
    ),
  );
}