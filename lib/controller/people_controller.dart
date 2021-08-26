import 'package:star_wars_filmes_personagens/model/people_model.dart';
import 'package:star_wars_filmes_personagens/model/people_repository.dart';

class PeopleController {

  late final PeopleRepository _repository;

  PeopleController([ PeopleRepository repository = const PeopleRepository() ]) {
    this._repository = repository;
  }

  Future<List<PeopleModel>> loadFilms() async {
    return _repository.findAll();
  }

}