import 'package:dio/dio.dart';
import 'package:studioghibli/data/model/film.dart';

class FilmRepository {
  final Dio dio;

  FilmRepository(this.dio);

  Future<List<Film>> getFilms() async {
    final response = await dio.get('/films');
    return (response.data as List).map((json) => Film.toJson(json)).toList();
  }

  Future<Film> getFilm(String id) async {
    final response = await dio.get('/films/$id');
    return Film.toJson(response.data);
  }

  Future<Film> getFilmsByUrl(String url) async {
    final response = await dio.get(url);

    return Film.toJson(response.data);
  }
}
