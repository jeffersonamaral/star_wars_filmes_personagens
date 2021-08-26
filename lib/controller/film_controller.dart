import 'package:star_wars_filmes_personagens/model/film_model.dart';
import 'package:star_wars_filmes_personagens/model/film_repository.dart';

class FilmController {

  late final FilmRepository _repository;

  FilmController([ FilmRepository repository = const FilmRepository() ]) {
    this._repository = repository;
  }

  Future<List<FilmModel>> loadFilms() async {
    return _repository.findAll();
  }

}