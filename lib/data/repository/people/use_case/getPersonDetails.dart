import 'package:studioghibli/controller/parseUrl.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';
import 'package:studioghibli/data/repository/people/entities/Person_Details.dart';
import 'package:studioghibli/data/repository/species/SpeciesRepository.dart';

class GetPersonDetails {
  final Peoplerepository peoplerepository;
  final FilmRepository filmRepository;
  final Speciesrepository speciesRepository;

  GetPersonDetails({
    required this.filmRepository,
    required this.speciesRepository,
    required this.peoplerepository,
  });

  Future<PersonDetails> call(String id) async {
    final person = await peoplerepository.getPerson(id);

    final films = await Future.wait(
      person.films.map((url) => filmRepository.getFilmsByUrl(url)),
    );

    final species = person.species.isNotEmpty
        ? await speciesRepository.geSpecy(person.species)
        : null;

    return PersonDetails(person: person, species: species, films: films);
  }
}
