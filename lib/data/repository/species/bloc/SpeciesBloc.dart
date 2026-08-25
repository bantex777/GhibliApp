import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesEvent.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesRepository.dart';
import 'package:studioghibli/data/repository/species/bloc/SpeciesState.dart';
import 'package:studioghibli/data/repository/species/use_case/Get_SpeciesDetails.dart';

class SpeciesBloc extends Bloc<SpeciesEvent, SpeciesState> {
  final Speciesrepository repository;
  final GetSpeciesDetails useCaseSpeciesDetails;

  SpeciesBloc(this.repository, this.useCaseSpeciesDetails)
    : super(SpeciesInitial()) {
    on<LoadSpecies>(_onLoadSpecies);
    on<LoadSpeciesDetails>(_onGetDetails);
  }

  Future<void> _onLoadSpecies(
    LoadSpecies event,
    Emitter<SpeciesState> emit,
  ) async {
    emit(SpeciesLoading());

    try {
      final species = await repository.getSpecies();

      emit(SpeciesSuccess(species));
    } catch (e) {
      emit(SpeciesFailure(e.toString()));
    }
  }

  Future<void> _onGetDetails(
    LoadSpeciesDetails event,
    Emitter<SpeciesState> emit,
  ) async {
    emit(state.copyWith(speciesDetails: null, isLoading: true, error: null));

    try {
      final details = await useCaseSpeciesDetails(event.id);
      emit(state.copyWith(speciesDetails: details, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
