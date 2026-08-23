import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:studioghibli/data/model/people.dart';
import 'package:studioghibli/domain/entities/filmDetails.dart';

class Peoplerepository {
  final Dio dio;

  Peoplerepository(this.dio);

  Future<List<People>> getPeoples() async {
    final response = await dio.get('/people');
    return (response.data as List).map((json) => People.toJson(json)).toList();
  }

  Future<People> getPeople(String url) async {
    print("getpeople >>>>>>>>>>>>>>>>> url");
    try {
      final response = await dio.get(url);

      return People.toJson(response.data);
    } on DioException catch (e) {
      //TODO error
      print('>>>>>>> error perople ${e.toString()}');
      rethrow;
    }
  }

  Future<People> getPerson(String id) async {
    print("getperoson >>>>>>>>>>>>>>>>> $id");
    try {
      final response = await dio.get('/people/$id');

      print("getperoson in >>>>>>>>>>>>>>>>> $response");
      return People.toJson(response.data);
    } on DioException catch (e) {
      //TODO error
      print('>>>>>>> error person ${e.toString()}');
      rethrow;
    }
  }
}
