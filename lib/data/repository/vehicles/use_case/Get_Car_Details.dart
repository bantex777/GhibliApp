import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/vehicles/bloc/CarRepository.dart';
import 'package:studioghibli/data/repository/vehicles/entities/Car_Details.dart';

class GetCarDetails {
  final CarRepository carRepository;
  final FilmRepository filmRepository;

  GetCarDetails({required this.carRepository, required this.filmRepository});

  Future<CarDetails> call(String id) async {
    final car = await carRepository.getCarByID(id);

    final films = await Future.wait(
      car.films.map((url) => filmRepository.getFilmsByUrl(url)),
    );

    return CarDetails(car: car, films: films);
  }
}
