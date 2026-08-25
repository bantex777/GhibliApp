abstract class SpeciesEvent {}

class LoadSpecies extends SpeciesEvent {}

class LoadSpeciesDetails extends SpeciesEvent {
  final String id;

  LoadSpeciesDetails(this.id);
}
