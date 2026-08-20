import 'package:studioghibli/data/model/vehichles.dart';

abstract class CarState {}

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
