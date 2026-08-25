import 'package:studioghibli/data/model/species.dart';
import 'package:studioghibli/data/repository/species/entities/Species_Details.dart';

class SpeciesState {
  final List<Species> species;
  final SpeciesDetails? speciesDetails;
  final bool isLoading;
  final String? error;

  SpeciesState({
    this.species = const [],
    this.speciesDetails,
    this.isLoading = false,
    this.error,
  });

  SpeciesState copyWith({
    List<Species>? species,
    SpeciesDetails? speciesDetails,
    bool? isLoading,
    Object? error = _unset,
  }) {
    return SpeciesState(
      species: species ?? this.species,
      speciesDetails: identical(speciesDetails, _unset)
          ? this.speciesDetails
          : speciesDetails as SpeciesDetails?,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _unset) ? this.error : error as String?,
    );
  }

  static const _unset = Object();
}

class SpeciesInitial extends SpeciesState {}

class SpeciesLoading extends SpeciesState {}

class SpeciesSuccess extends SpeciesState {
  final List<Species> species;

  SpeciesSuccess(this.species);
}

class SpeciesFailure extends SpeciesState {
  final String message;

  SpeciesFailure(this.message);
}
