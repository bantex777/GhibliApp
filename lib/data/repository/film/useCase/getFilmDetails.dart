import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/location/LocationRepository.dart';
import 'package:studioghibli/data/repository/people/PeopleRepository.dart';
import 'package:studioghibli/data/repository/species/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/vehicles/CarRepository.dart';
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

    print('FILM OK: ${film.title}');

    print('PEOPLE: ${film.people}');
    final people = await Future.wait(
      film.people.map((url) async {
        final uri = Uri.parse(url);
        final lastSegment = uri.pathSegments.isEmpty
            ? uri.pathSegments.last
            : '';

        if (lastSegment.isNotEmpty && lastSegment != 'people') {
          final people = await peopleRepo.getPeople(url);

          return [people];
        } else {
          return await peopleRepo.getPeoples();
        }
      }),
    );

    final peopleFlat = people.expand((list) => list).toList();

    print('PEOPLE OK');

    print('LOCATIONS: ${film.locations}');
    final locations = await locationRepo.getLocationsByFilm(film.url);

    print('LOCATIONS OK');

    print('SPECIES: ${film.species}');
    final species = await Future.wait(
      film.species.map((url) => speciesRepo.geSpecy(url)),
    );

    print('SPECIES OK');

    print('VEHICLES: ${film.vehicles}');
    final vehicles = await Future.wait(
      film.people.map((url) async {
        final uri = Uri.parse(url);
        final lastSegment = uri.pathSegments.isEmpty
            ? uri.pathSegments.last
            : '';

        if (lastSegment.isNotEmpty && lastSegment != 'vehicles') {
          final people = await carRepo.getCar(url);

          return [people];
        } else {
          return await carRepo.getCars();
        }
      }),
    );

    final carFlat = vehicles.expand((list) => list).toList();

    print('VEHICLES OK');

    return FilmDetails(
      film: film,
      people: peopleFlat,
      locations: locations,
      species: species,
      vehicles: carFlat,
    );
  }
}
