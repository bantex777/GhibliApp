import 'package:studioghibli/data/model/species.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/species/entities/Species_Details.dart';

class GetSpeciesDetails {
  final Speciesrepository speciesrepository;
  final Peoplerepository peoplerepository;
  final FilmRepository filmRepository;

  GetSpeciesDetails({
    required this.speciesrepository,
    required this.peoplerepository,
    required this.filmRepository,
  });

  Future<SpeciesDetails> call(String id) async {
    final species = await speciesrepository.getSpeciesWithId(id);

    final people = await Future.wait(
      species.people.map((url) => peoplerepository.getPeople(url)),
    );

    final films = await Future.wait(
      species.films.map((url) => filmRepository.getFilmsByUrl(url)),
    );

    return SpeciesDetails(species: species, people: people, films: films);
  }
}
