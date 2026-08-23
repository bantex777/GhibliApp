import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/people.dart';
import 'package:studioghibli/data/model/species.dart';

class PersonDetails {
  final People person;
  final List<Film> films;
  final Species? species;

  PersonDetails({
    required this.person,
    this.films = const [],
    required this.species,
  });
}
