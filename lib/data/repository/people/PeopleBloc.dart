// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/people/PeopleEvent.dart';
import 'package:studioghibli/data/repository/people/PeopleRepository.dart';
import 'package:studioghibli/data/repository/people/PeopleState.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final Peoplerepository repository;

  PeopleBloc(this.repository) : super(PeopleInitial()) {
    on<LoadPeople>(_onLoadPeople);
  }

  Future<void> _onLoadPeople(
    LoadPeople event,
    Emitter<PeopleState> emit,
  ) async {
    emit(PeopleLoading());

    try {
      final people = await repository.getPeoples();

      emit(PeopleSuccess(people));
    } catch (e) {
      emit(PeopleFailure(e.toString()));
    }
  }
}
