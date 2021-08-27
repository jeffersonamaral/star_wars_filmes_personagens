import 'package:star_wars_filmes_personagens/model/favorite_model.dart';
import 'package:star_wars_filmes_personagens/model/favorite_repository.dart';

class FavoriteController {

  late FavoriteRepository _repository;

  FavoriteController(this._repository);

  Future<List<FavoriteModel>> findAll() async {
    return _repository.findAll();
  }

  void save(FavoriteModel favoriteModel) async {
    _repository.save(favoriteModel);
  }

  void delete(FavoriteModel favoriteModel) async {
    _repository.delete(favoriteModel);
  }

}