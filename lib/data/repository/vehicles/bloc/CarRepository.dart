import 'package:dio/dio.dart';
import 'package:studioghibli/data/model/vehichles.dart';

class CarRepository {
  final Dio dio;

  CarRepository(this.dio);

  Future<List<Vehicle>> getCars() async {
    final response = await dio.get('/vehicles');

    return (response.data as List).map((json) => Vehicle.toJson(json)).toList();
  }

  Future<Vehicle> getCarByID(String id) async {
    final response = await dio.get('/vehicles/$id');

    return Vehicle.toJson(response.data);
  }

  Future<Vehicle> getCarByURL(String url) async {
    final response = await dio.get(url);
    return Vehicle.toJson(response.data);
  }
}
