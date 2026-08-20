import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:studioghibli/data/model/homeGrid.dart';

Future<List<HomeGrid>> LoadMenu() async {
  final String response = await rootBundle.loadString(
    'assets/data/gridValue.json',
  );
  final List<dynamic> data = json.decode(response);
  return data.map((item) => HomeGrid.fromJson(item)).toList();
}
