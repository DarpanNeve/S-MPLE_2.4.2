part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable{}

class MapInitial extends MapState{

  @override
  List<Object?> get props => [];
}

class MapLoading extends MapState{
  @override
  List<Object?> get props => [];
}
class MapLoaded extends MapState{
  final LatLng location;
  MapLoaded(this.location);
  @override
  List<Object?> get props => [location];
}