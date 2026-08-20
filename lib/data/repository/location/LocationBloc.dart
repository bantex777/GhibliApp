import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/location/LocationEvent.dart';
import 'package:studioghibli/data/repository/location/LocationRepository.dart';
import 'package:studioghibli/data/repository/location/LocationState.dart';

class LocationBloc extends Bloc<Locationevent, LocationState> {
  final LocationRepository repository;

  LocationBloc(this.repository) : super(LocationInitial()) {
    on<LoadLocation>(_onLoadLocation);
  }

  Future<void> _onLoadLocation(
    LoadLocation event,
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
}
