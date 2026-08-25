import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationEvent.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationRepository.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationState.dart';
import 'package:studioghibli/data/repository/location/entities/Location_Details.dart';
import 'package:studioghibli/data/repository/location/use_case/getLocationDetails.dart';

class LocationBloc extends Bloc<Locationevent, LocationState> {
  final LocationRepository repository;
  final Getlocationdetails useCaseLocation;

  LocationBloc(this.repository, this.useCaseLocation)
    : super(LocationInitial()) {
    on<LoadLocations>(_onLoadLocation);
    on<GetLocationDetails>(_onLoadLocationDetails);
  }

  Future<void> _onLoadLocation(
    LoadLocations event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    try {
      final location = await repository.getLocations();
      emit(LocationSuccess(location));
    } catch (e) {
      emit(LocationFailed(e.toString()));
    }
  }

  Future<void> _onLoadLocationDetails(
    GetLocationDetails event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(locationDetails: null, isLoading: true, error: null));
    try {
      final details = await useCaseLocation(event.id);
      emit(state.copyWith(locationDetails: details, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
