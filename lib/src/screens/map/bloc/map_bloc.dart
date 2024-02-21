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
        print('printing from snapshot ${snapshot.value}');
        if (snapshot.value != null) {
          final List<dynamic>? dataList = snapshot.value as List<dynamic>?;
          if (dataList != null) {
            final List<Hospital> hospitals = dataList.map((data) {
              // Fetch ratings if available
              List<Rating> ratings = [];
              if (data['ratings'] != null) {
                final List<dynamic> ratingList = data['ratings'] as List<dynamic>;
                ratings = ratingList.map((ratingData) {
                  return Rating(
                    uid: ratingData['uid'] ?? '',
                    userName: ratingData['userName'] ?? '',
                    rating: (ratingData['rating'] as num?)?.toDouble() ?? 0.0,
                    comment: ratingData['comment'] ?? '',
                  );
                }).toList();
              }

              return Hospital(
                name: data['name'] ?? '',
                latitude: (data['latitude'] as num?)?.toDouble() ?? 0.0,
                longitude: (data['longitude'] as num?)?.toDouble() ?? 0.0,
                elevation: data['elevation'] ?? '',
                phone: data['phone'] ?? '',
                website: data['website'] ?? '',
                reviews: (data['reviews'] as num?)?.toDouble() ?? 0.0,
                ratings: ratings, // Pass the fetched ratings
              );
            }).toList();

            emit(MapLoaded(LatLng(locationData.latitude!, locationData.longitude!), hospitals));
          } else {
            emit(MapError('Data from Firebase is not in the expected format'));
          }
        } else {
          emit(MapError('Data from Firebase is null'));
        }

      }catch(e){
        emit(MapError(e.toString()));
      }
    });

  }
}