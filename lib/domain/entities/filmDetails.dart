import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/location.dart';
import 'package:studioghibli/data/model/people.dart';
import 'package:studioghibli/data/model/species.dart';
import 'package:studioghibli/data/model/vehichles.dart';

class FilmDetails {
  final Film film;
  final List<People> people;
  final List<Location> locations;
  final List<Species> species;
  final List<Vehicle> vehicles;

  FilmDetails({
    required this.film,
    this.people = const [],
    this.locations = const [],
    this.species = const [],
    this.vehicles = const [],
  });
}
