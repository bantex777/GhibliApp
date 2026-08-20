import 'package:studioghibli/data/model/film.dart';
import 'package:studioghibli/data/model/people.dart';

class Species {
  final String id;
  final String name;
  final String classification;
  final String eyeColors;
  final String hairColors;
  final String url;
  final List<String> people;
  final List<String> films;

  Species({
    required this.id,
    required this.name,
    required this.classification,
    required this.eyeColors,
    required this.hairColors,
    required this.url,
    required this.people,
    required this.films,
  });

  factory Species.toJson(Map<String, dynamic> json) {
    return Species(
      id: json['id'],
      name: json['name'],
      classification: json['classification'],
      eyeColors: json['eye_colors'],
      hairColors: json['hair_colors'],
      url: json['url'],
      people: List<String>.from(json['people'] ?? []),
      films: List<String>.from(json['films'] ?? []),
    );
  }
}
