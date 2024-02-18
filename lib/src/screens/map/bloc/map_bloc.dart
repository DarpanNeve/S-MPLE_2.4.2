import 'dart:async';
import 'package:location/location.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_config/flutter_config.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapLoad>((event, emit)async {
      Location location = Location();
      LocationData locationData;
      locationData = await location.getLocation();
      print('getting');
      print(" LOCATION $locationData");
      print(locationData.latitude);
      print(locationData.longitude);
      const radius = 10000;
      const type = 'hospital';

      final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=${locationData.latitude},${locationData.longitude}'
          '&radius=$radius'
          '&type=$type'
          '&key=${FlutterConfig.get('GOOGLE_MAP')}';

      List<LatLng> hospitals = [];
      emit(MapLoaded(LatLng(locationData.latitude!, locationData.longitude!), hospitals));
    });

  }
}
