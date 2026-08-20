import 'package:studioghibli/data/model/location.dart' show Location;

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<Location> location;

  LocationSuccess(this.location);
}

class LocationFailed extends LocationState {
  final String message;

  LocationFailed(this.message);
}
