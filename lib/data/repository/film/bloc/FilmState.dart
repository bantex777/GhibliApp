// ignore: file_names
// ignore_for_file: file_names

import 'package:studioghibli/domain/entities/filmDetails.dart';
import 'package:studioghibli/data/model/film.dart';

// abstract class FilmState {}

class FilmInitial extends FilmState {}

class FilmLoading extends FilmState {}

class FilmSuccess extends FilmState {
  final List<Film> films;

  FilmSuccess(this.films);
}

class FilmDetailsSuccess extends FilmState {
  final FilmDetails filmDetails;

  FilmDetailsSuccess(this.filmDetails);
}

class FilmFailure extends FilmState {
  final String message;

  FilmFailure(this.message);
}

class FilmState {
  final List<Film> films;
  final FilmDetails? filmDetails;
  final bool isLoading;
  final String? error;

  const FilmState({
    this.films = const [],
    this.filmDetails,
    this.isLoading = false,
    this.error,
  });

  FilmState copyWith({
    List<Film>? films,
    FilmDetails? filmDetails,
    bool? isLoading,
    Object? error = _unset,
  }) {
    return FilmState(
      films: films ?? this.films,
      filmDetails: identical(filmDetails, _unset)
          ? this.filmDetails
          : filmDetails as FilmDetails?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

  static const _unset = Object();
}
