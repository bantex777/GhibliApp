abstract class FilmEvent {}

class LoadFilms extends FilmEvent {}

class LoadFilm extends FilmEvent {
  final String id;

  LoadFilm(this.id);
}
