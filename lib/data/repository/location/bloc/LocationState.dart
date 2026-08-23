import 'package:studioghibli/data/model/location.dart' show Location;
import 'package:studioghibli/data/repository/location/entities/Location_Details.dart';

class LocationState {
  final List<Location> locations;
  final LocationDetails? locationDetails;
  final bool isLoading;
  final String? error;

  LocationState({
    this.locations = const [],
    this.locationDetails,
    this.isLoading = false,
    this.error,
  });

  LocationState copyWith({
    List<Location>? locations,
    LocationDetails? locationDetails,
    bool? isLoading,
    Object? error = _unset,
  }) {
    return LocationState(
      locations: locations ?? this.locations,
      locationDetails: identical(locationDetails, _unset)
          ? this.locationDetails
          : locationDetails as LocationDetails?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

  static const _unset = Object();
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<Location> locations;

  LocationSuccess(this.locations);
}

class LocationFailed extends LocationState {
  final String message;

  LocationFailed(this.message);
}
