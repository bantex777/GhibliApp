import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/people.dart';
import 'package:studioghibli/data/model/species.dart';

class SpeciesDetails {
  final Species species;
  final List<People> people;
  final List<Film> films;

  SpeciesDetails({
    required this.species,
    this.people = const [],
    this.films = const [],
  });
}
