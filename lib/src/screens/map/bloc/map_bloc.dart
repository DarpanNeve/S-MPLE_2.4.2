import 'package:location/location.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:firebase_database/firebase_database.dart';

import '../hospital_model.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapLoad>((event, emit)async {
      try{
        emit(MapLoading());
        Location location = Location();
        LocationData locationData;
        locationData = await location.getLocation();
        print('getting');
        print(" LOCATION $locationData");
        print(locationData.latitude);
        print(locationData.longitude);
        print('got');
        final List<Hospital> hospitals = [];

        final snapshot = await FirebaseDatabase.instance.ref('Hospital').get();
        print(snapshot.value);
        if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
          final map = snapshot.value as Map<dynamic, dynamic>;

          map.forEach((key, value) {
            final hospital = Hospital.fromMap(value);
            hospitals.add(hospital);
          });
          print(hospitals);
        } else {
          emit(MapError('Data from Firebase is null or not a Map<dynamic, dynamic>'));
        }
        emit(MapLoaded(LatLng(locationData.latitude!, locationData.longitude!), hospitals));
      }catch(e){
        emit(MapError(e.toString()));
      }
    });

  }
}
