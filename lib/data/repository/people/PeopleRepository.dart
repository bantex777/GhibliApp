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
    try {
      final response = await dio.get(url);

      print('>>>>>>>>>>>>>>>> $url');

      return People.toJson(response.data);
    } on DioException catch (e) {
      //TODO error
      print('>>>>>>> error perople ${e.toString()}');
      rethrow;
    }
  }
}
