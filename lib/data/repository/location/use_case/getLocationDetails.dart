import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationRepository.dart';
import 'package:studioghibli/data/repository/location/entities/Location_Details.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';

class Getlocationdetails {
  final LocationRepository locationRepository;
  final FilmRepository filmRepository;
  final Peoplerepository peoplerepository;

  Getlocationdetails({
    required this.locationRepository,
    required this.filmRepository,
    required this.peoplerepository,
  });

  Future<LocationDetails> call(String id) async {
    final location = await locationRepository.getLocationById(id);

    print(">>>>>>>>>>> location done");

    final films = await Future.wait(
      location.films.map((url) => filmRepository.getFilmsByUrl(url)),
    );

    print(">>>>>>>>>>> film done");

    final residents = await Future.wait(
      location.residents.map((url) => peoplerepository.getPeople(url)),
    );

    print(">>>>>>>>>>> person done");

    return LocationDetails(
      location: location,
      films: films,
      residents: residents,
    );
  }
}
