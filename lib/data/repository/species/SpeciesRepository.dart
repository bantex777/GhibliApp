import 'package:dio/dio.dart';
import 'package:studioghibli/data/model/species.dart';

class Speciesrepository {
  final Dio dio;

  Speciesrepository(this.dio);

  Future<List<Species>> getSpecies() async {
    final response = await dio.get('/species');

    return (response.data as List).map((json) => Species.toJson(json)).toList();
  }

  Future<Species> geSpecy(String url) async {
    final response = await dio.get(url);
    return Species.toJson(response.data);
  }
}
