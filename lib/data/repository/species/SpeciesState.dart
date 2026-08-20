import 'package:studioghibli/data/model/species.dart';

abstract class Speciesstate {}

class SpeciesInitial extends Speciesstate {}

class SpeciesLoading extends Speciesstate {}

class SpeciesSuccess extends Speciesstate {
  final List<Species> species;

  SpeciesSuccess(this.species);
}

class SpeciesFailure extends Speciesstate {
  final String message;

  SpeciesFailure(this.message);
}
