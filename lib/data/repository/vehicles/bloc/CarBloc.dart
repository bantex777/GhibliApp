import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarRepository.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarState.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CardEvent.dart';
import 'package:studioghibli/data/repository/vehicles/use_case/Get_Car_Details.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository repository;
  final GetCarDetails useCaseCarDetails;

  CarBloc(this.repository, this.useCaseCarDetails) : super(CarInitial()) {
    on<LoadCars>(_onLoadCars);
    on<LoadCarDetails>(_onLoadCarDetails);
  }

  Future<void> _onLoadCars(LoadCars event, Emitter<CarState> emit) async {
    emit(CarLoading());

    try {
      final cars = await repository.getCars();

      emit(CarSuccess(cars));
    } catch (e) {
      emit(CarFailure(e.toString()));
    }
  }

  Future<void> _onLoadCarDetails(
    LoadCarDetails event,
    Emitter<CarState> emit,
  ) async {
    emit(state.copyWith(carDetails: null, isLoading: true, error: null));

    try {
      final details = await useCaseCarDetails(event.id);
      emit(state.copyWith(carDetails: details, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
