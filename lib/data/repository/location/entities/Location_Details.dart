import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/location.dart';
import 'package:studioghibli/data/model/people.dart';

class LocationDetails {
  final Location location;
  final List<People> residents;
  final List<Film> films;

  LocationDetails({
    required this.location,
    this.residents = const [],
    this.films = const [],
  });
}
