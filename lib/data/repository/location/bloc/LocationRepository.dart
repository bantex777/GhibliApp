import 'package:dio/dio.dart';
import 'package:studioghibli/data/model/location.dart';

class LocationRepository {
  final Dio dio;

  LocationRepository(this.dio);

  Future<List<Location>> getLocations() async {
    final response = await dio.get('/locations');
    print(">>>>>>>>>>>> $response");

    return (response.data as List)
        .map((json) => Location.toJson(json))
        .toList();
  }

  Future<Location> getLocation(String url) async {
    final response = await dio.get(url);
    return Location.toJson(response.data);
  }

  Future<Location> getLocationById(String id) async {
    final response = await dio.get('/locations/$id');
    return Location.toJson(response.data);
  }

  Future<List<Location>> getLocationsByFilm(String filmUrl) async {
    final response = await dio.get('/locations');

    final locations = (response.data as List)
        .map((json) => Location.toJson(json))
        .toList();

    return locations.where((location) {
      return location.films.contains(filmUrl);
    }).toList();
  }
}
