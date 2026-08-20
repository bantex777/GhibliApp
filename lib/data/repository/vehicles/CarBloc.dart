import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/vehicles/CarRepository.dart';
import 'package:studioghibli/data/repository/vehicles/CarState.dart';
import 'package:studioghibli/data/repository/vehicles/CardEvent.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository repository;

  CarBloc(this.repository) : super(CarInitial()) {
    on<LoadCars>(_onLoadCars);
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
}
