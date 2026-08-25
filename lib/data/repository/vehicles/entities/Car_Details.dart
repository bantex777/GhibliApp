import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/vehichles.dart';

class CarDetails {
  final Vehicle car;
  final List<Film> films;

  CarDetails({required this.car, this.films = const []});
}
