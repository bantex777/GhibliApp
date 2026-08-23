abstract class PeopleEvent {}

class LoadPeople extends PeopleEvent {}

class LoadPerson extends PeopleEvent {
  final String id;

  LoadPerson(this.id);
}
