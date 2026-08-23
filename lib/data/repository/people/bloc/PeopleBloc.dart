// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/film/bloc/FilmState.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleEvent.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleRepository.dart';
import 'package:studioghibli/data/repository/people/bloc/PeopleState.dart';
import 'package:studioghibli/data/repository/people/use_case/getPersonDetails.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final Peoplerepository repository;
  final GetPersonDetails personUseCase;

  PeopleBloc(this.repository, this.personUseCase) : super(PeopleInitial()) {
    on<LoadPeople>(_onLoadPeople);
    on<LoadPerson>(_onLoadPersonDetails);
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

  Future<void> _onLoadPersonDetails(
    LoadPerson event,
    Emitter<PeopleState> emit,
  ) async {
    emit(state.copyWith(personDetails: null, isLoading: true, error: null));

    try {
      final details = await personUseCase(event.id);

      emit(state.copyWith(personDetails: details, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
