import 'package:studioghibli/data/model/people.dart';

abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class PeopleLoading extends PeopleState {}

class PeopleSuccess extends PeopleState {
  final List<People> people;

  PeopleSuccess(this.people);
}

class PeopleFailure extends PeopleState {
  final String message;

  PeopleFailure(this.message);
}
