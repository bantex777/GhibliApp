import 'package:studioghibli/data/model/people.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/people/entities/Person_Details.dart';

//abstract class PeopleState {}

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

class PeopleState {
  final List<People> people;
  final PersonDetails? personDetails;
  final bool isLoading;
  final String? error;

  const PeopleState({
    this.people = const [],
    this.personDetails,
    this.isLoading = false,
    this.error,
  });

  PeopleState copyWith({
    List<People>? people,
    PersonDetails? personDetails,
    bool? isLoading,
    Object? error = _unset,
  }) {
    return PeopleState(
      people: people ?? this.people,
      personDetails: identical(personDetails, _unset)
          ? this.personDetails
          : personDetails as PersonDetails?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

  static const _unset = Object();
}
