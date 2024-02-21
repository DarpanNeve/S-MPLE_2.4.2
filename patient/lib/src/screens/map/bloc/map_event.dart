part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable{}

class MapLoad extends MapEvent{
  @override
  List<Object?> get props => [];
}

class MapUpdate extends MapEvent{
  final LatLng location;
  MapUpdate(this.location);
  @override
  List<Object?> get props => [location];
}