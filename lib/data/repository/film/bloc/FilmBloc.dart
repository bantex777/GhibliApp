import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmEvent.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmRepository.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/film/useCase/getFilmDetails.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmRepository repository;
  final GetFilmDetails filmDetailsCase;

  FilmBloc(this.repository, this.filmDetailsCase) : super(FilmInitial()) {
    on<LoadFilms>(_onLoadFilms);
    on<LoadFilm>(_onLoadFilm);
  }

  Future<void> _onLoadFilms(LoadFilms event, Emitter<FilmState> emit) async {
    emit(FilmLoading());

    try {
      final films = await repository.getFilms();

      emit(FilmSuccess(films));
    } catch (e) {
      emit(FilmFailure(e.toString()));
    }
  }

  Future<void> _onLoadFilm(LoadFilm event, Emitter<FilmState> emit) async {
    emit(state.copyWith(filmDetails: null, isLoading: true, error: null));

    try {
      final details = await filmDetailsCase(event.id);

      emit(state.copyWith(filmDetails: details, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
