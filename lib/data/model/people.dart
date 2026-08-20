class People {
  final String id;
  final String name;
  final String gender;
  final String age;
  final String eyeColor;
  final String hairColor;
  final List<String> films;
  final String species;
  final String url;

  People({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.eyeColor,
    required this.hairColor,
    required this.films,
    required this.species,
    required this.url,
  });

  factory People.toJson(Map<String, dynamic> json) {
    return People(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      eyeColor: json['eye_color'],
      hairColor: json['hair_color'],
      films: List<String>.from(json['films'] ?? []),
      species: json['species'],
      url: json['url'],
    );
  }
}
