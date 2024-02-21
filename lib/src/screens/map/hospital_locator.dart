import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../utils/strings_english.dart';
import '../appointments/book_appointment.dart';
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
  void _showHospitalInfoBottomSheet(BuildContext context, Hospital hospital) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: _buildHospitalInfo(hospital,context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoaded) {
            print(state.hospitals);
            return GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: state.location,
                  zoom: 11.0,
                ),
                myLocationEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId(dhanwantiHospitalNigdi),
                    position: LatLng(18.65586645, 73.76812952),
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, new Hospital(
                          name: dhanwantiHospitalNigdi,
                          latitude: 18.65586645,
                          longitude: 73.76812952,
                          elevation: '602',
                          phone: '8605018483',
                          website: dhanwantiHospitalNigdiSite,
                          reviews: 3.3
                      ));
                    },
                  ),
                  Marker(
                    markerId: MarkerId(pdaAyurvedicHospital),
                    position: LatLng(18.6548547, 73.7696807),
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, new Hospital(
                          name: pdaAyurvedicHospital,
                          latitude: 18.6548547,
                          longitude: 73.7696807,
                          elevation: '601',
                          phone: '2027332700',
                          website: pdaAyurvedicHospitalSite,
                          reviews: 3.3
                      ));
                    },
                  ),
                  Marker(
                    markerId: MarkerId(diwanHospitalPune),
                    position: LatLng(18.6579111, 73.7762953),
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, new Hospital(
                          name: diwanHospitalPune,
                          latitude: 18.6579111,
                          longitude: 73.7762953,
                          elevation: '593',
                          phone: '8080707691',
                          website: diwanHospitalPuneSite,
                          reviews: 4.4
                      ));
                    },
                  ),
                  Marker(
                    markerId: MarkerId(aditiMultiHospital),
                    position: LatLng(18.6561789, 73.77319634),
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, new Hospital(
                          name: aditiMultiHospital,
                          latitude: 18.6561789,
                          longitude: 73.77319634,
                          elevation: '594',
                          phone: '9881212100',
                          website: aditiMultiHospitalSite,
                          reviews: 4.6
                      ));
                    },
                  )
                });
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


Widget _buildHospitalInfo(Hospital hospital,BuildContext context) {
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
            )
            // Add more information as needed
          ],
        ),
      ),
    ),
  );
}