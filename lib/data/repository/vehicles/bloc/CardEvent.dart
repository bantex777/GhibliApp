abstract class CarEvent {}

class LoadCars extends CarEvent {}

class LoadCarDetails extends CarEvent {
  final String id;

  LoadCarDetails(this.id);
}
