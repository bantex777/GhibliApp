import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:studioghibli/core/network/dio_client.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/film/use_case/getFilmDetails.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationBloc.dart';
import 'package:studioghibli/data/repository/location/bloc/LocationRepository.dart';
import 'package:studioghibli/data/repository/location/use_case/getLocationDetails.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';
import 'package:studioghibli/data/repository/people/use_case/getPersonDetails.dart';
import 'package:studioghibli/data/repository/species/SpeciesBloc.dart';
import 'package:studioghibli/data/repository/species/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/vehicles/CarBloc.dart';
import 'package:studioghibli/data/repository/vehicles/CarRepository.dart';

final locator = GetIt.instance;

void setupDI() {
  //Dio
  locator.registerLazySingleton<Dio>(() => Dio(DioClient.create()));

  locator.registerLazySingleton<FilmRepository>(
    () => FilmRepository(locator<Dio>()),
  );

  locator.registerLazySingleton<Peoplerepository>(
    () => Peoplerepository(locator<Dio>()),
  );

  locator.registerLazySingleton<LocationRepository>(
    () => LocationRepository(locator<Dio>()),
  );

  locator.registerLazySingleton<Speciesrepository>(
    () => Speciesrepository(locator<Dio>()),
  );

  locator.registerLazySingleton<CarRepository>(
    () => CarRepository(locator<Dio>()),
  );

  locator.registerLazySingleton<GetFilmDetails>(
    () => GetFilmDetails(
      filmRepo: locator<FilmRepository>(),
      peopleRepo: locator<Peoplerepository>(),
      locationRepo: locator<LocationRepository>(),
      speciesRepo: locator<Speciesrepository>(),
      carRepo: locator<CarRepository>(),
    ),
  );

  locator.registerFactory<FilmBloc>(
    () => FilmBloc(locator<FilmRepository>(), locator<GetFilmDetails>()),
  );

  locator.registerFactory<LocationBloc>(
    () => LocationBloc(
      locator<LocationRepository>(),
      locator<Getlocationdetails>(),
    ),
  );

  locator.registerFactory<PeopleBloc>(
    () => PeopleBloc(locator<Peoplerepository>(), locator<GetPersonDetails>()),
  );

  locator.registerFactory<SpeciesBloc>(
    () => SpeciesBloc(locator<Speciesrepository>()),
  );

  locator.registerFactory<CarBloc>(() => CarBloc(locator<CarRepository>()));

  locator.registerLazySingleton<GetPersonDetails>(
    () => GetPersonDetails(
      peoplerepository: locator<Peoplerepository>(),
      filmRepository: locator<FilmRepository>(),
      speciesRepository: locator<Speciesrepository>(),
    ),
  );

  locator.registerLazySingleton<Getlocationdetails>(
    () => Getlocationdetails(
      locationRepository: locator<LocationRepository>(),
      filmRepository: locator<FilmRepository>(),
      peoplerepository: locator<Peoplerepository>(),
    ),
  );
}
