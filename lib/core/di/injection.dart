import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:studioghibli/core/network/dio_client.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmBloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/film/useCase/getFilmDetails.dart';
import 'package:studioghibli/data/repository/location/LocationBloc.dart';
import 'package:studioghibli/data/repository/location/LocationRepository.dart';
import 'package:studioghibli/data/repository/people/PeopleBloc.dart';
import 'package:studioghibli/data/repository/people/PeopleRepository.dart';
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
    () => LocationBloc(locator<LocationRepository>()),
  );

  locator.registerFactory<PeopleBloc>(
    () => PeopleBloc(locator<Peoplerepository>()),
  );

  locator.registerFactory<SpeciesBloc>(
    () => SpeciesBloc(locator<Speciesrepository>()),
  );

  locator.registerFactory<CarBloc>(() => CarBloc(locator<CarRepository>()));
}
