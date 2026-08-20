import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/species/SpeciesEvent.dart';
import 'package:studioghibli/data/repository/species/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/species/SpeciesState.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, Speciesstate> {
  final Speciesrepository repository;

  SpeciesBloc(this.repository) : super(SpeciesInitial()) {
    on<LoadSpecies>(_onLoadSpecies);
  }

  Future<void> _onLoadSpecies(
    LoadSpecies event,
    Emitter<Speciesstate> emit,
  ) async {
    emit(SpeciesLoading());

    try {
      final species = await repository.getSpecies();

      emit(SpeciesSuccess(species));
    } catch (e) {
      emit(SpeciesFailure(e.toString()));
    }
  }
}
