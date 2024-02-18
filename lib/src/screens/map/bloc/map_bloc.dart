import 'dart:convert';
import 'package:location/location.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
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
      const type = 'hospital';
      const String _baseUrlNearBySearch =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
      final String _placesApi='${FlutterConfig.get('GOOGLE_MAP')}';
      final String _location = "location=${locationData.latitude},${locationData.longitude}";
      const rankBy = "&rankby=distance";
      final url =
      Uri.parse(_baseUrlNearBySearch + _location + rankBy + type + _placesApi);

      final response = await http.get(Uri.parse(_baseUrlNearBySearch + _location + rankBy + type + _placesApi));
      List<LatLng> hospitals = [];
      if (response.statusCode == 200){
        print('response');
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final results = jsonData['results'] as List<dynamic>;
        for (var result in results) {
          final geometry = result['geometry'];
          final location = geometry['location'];
          final lat = location['lat'];
          final lng = location['lng'];
          hospitals.add(LatLng(lat, lng));
        }
      }

      emit(MapLoaded(LatLng(locationData.latitude!, locationData.longitude!), hospitals));
    });

  }
}
