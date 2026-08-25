import 'package:studioghibli/data/model/vehichles.dart';
import 'package:studioghibli/data/repository/vehicles/entities/Car_Details.dart';

class CarState {
  final List<Vehicle> cars;
  final CarDetails? carDetails;
  final bool isLoading;
  final String? error;

  const CarState({
    this.cars = const [],
    this.carDetails,
    this.isLoading = false,
    this.error,
  });

  CarState copyWith({
    List<Vehicle>? cars,
    CarDetails? carDetails,
    bool? isLoading,
    Object? error = _unset,
  }) {
    return CarState(
      cars: cars ?? this.cars,
      carDetails: identical(carDetails, _unset)
          ? this.carDetails
          : carDetails as CarDetails?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

  static const _unset = Object();
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarSuccess extends CarState {
  final List<Vehicle> cars;

  CarSuccess(this.cars);
}

class CarFailure extends CarState {
  final String message;

  CarFailure(this.message);
}
