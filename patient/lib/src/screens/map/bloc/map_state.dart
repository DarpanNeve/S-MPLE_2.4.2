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
  final List<Hospital>hospitals;
  MapLoaded(this.location,this.hospitals);
  @override
  List<Object?> get props => [location, hospitals];
}
class MapError extends MapState{
  final String message;
  MapError(this.message);
  @override
  List<Object?> get props => [message];
}