import 'package:dio/dio.dart';

class DioClient {
  static BaseOptions create() {
    return BaseOptions(
      baseUrl: 'https://ghibliapi.vercel.app',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
  }
}
