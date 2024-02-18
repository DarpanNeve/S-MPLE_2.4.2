import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
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
  void _showHospitalInfoBottomSheet(BuildContext context, List<Hospital> hospitals) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hospitals.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildHospitalInfo(hospitals[index]);
            },
          ),
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
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: state.location,
                zoom: 11.0,
              ),
              myLocationEnabled: true,
              markers: Set<Marker>.of(
                state.hospitals.map((Hospital hospital) {
                  return Marker(
                    markerId: MarkerId(hospital.name),
                    position: LatLng(hospital.latitude, hospital.longitude),
                    onTap: () {
                      _showHospitalInfoBottomSheet(context, state.hospitals);
                    },
                    infoWindow: InfoWindow(
                      title: hospital.name,
                      snippet: 'Rating: ${hospital.reviews}',
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  );
                }),
              ),
            );
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
                  child: Text('Press the button to load the map')),

            ),
          );
       },
       ),
      );
  }
}


Widget _buildHospitalInfo(Hospital hospital) {
  return Container(
    width: 250,
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
            child: Text('Rating: ${hospital.reviews}'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Phone: ${hospital.phone}'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Website: ${hospital.website}'),
          ),
          // Add more information as needed
        ],
      ),
    ),
  );
}