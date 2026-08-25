import 'package:studioghibli/controller/parseUrl.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationRepository.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarRepository.dart';
import 'package:studioghibli/domain/entities/filmDetails.dart';

class GetFilmDetails {
  final FilmRepository filmRepo;
  final Peoplerepository peopleRepo;
  final LocationRepository locationRepo;
  final Speciesrepository speciesRepo;
  final CarRepository carRepo;

  GetFilmDetails({
    required this.filmRepo,
    required this.peopleRepo,
    required this.locationRepo,
    required this.speciesRepo,
    required this.carRepo,
  });

  Future<FilmDetails> call(String id) async {
    final film = await filmRepo.getFilm(id);

    final people = await Future.wait(
      film.people.map((url) async {
        final parse = ParseUrl(url);

        if (parse.isNotEmpty && parse != 'people') {
          final people = await peopleRepo.getPeople(url);

          return [people];
        } else {
          return await peopleRepo.getPeoples();
        }
      }),
    );

    final peopleFlat = people.expand((list) => list).toList();

    final locations = await locationRepo.getLocationsByFilm(film.url);

    final species = await Future.wait(
      film.species.map((url) async {
        final parse = ParseUrl(url);

        if (parse.isNotEmpty && parse != 'vehicles') {
          final people = await speciesRepo.getSpeciesWithURL(url);

          return [people];
        } else {
          return await speciesRepo.getSpecies();
        }
      }),
    );

    final flatSpecies = species.expand((list) => list).toList();

    final vehicles = await Future.wait(
      film.people.map((url) async {
        final parse = ParseUrl(url);

        if (parse.isNotEmpty && parse != 'vehicles') {
          final people = await carRepo.getCarByURL(url);

          return [people];
        } else {
          return await carRepo.getCars();
        }
      }),
    );

    final carFlat = vehicles.expand((list) => list).toList();

    return FilmDetails(
      film: film,
      people: peopleFlat,
      locations: locations,
      species: flatSpecies,
      vehicles: carFlat,
    );
  }
}
